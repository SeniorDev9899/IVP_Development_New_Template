<?php
namespace App\Http\Controllers\Demo;

use App\User;
use App\Avatars;    

// New Added

use App\Regions;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\File; 

class PagesController extends Controller
{
    public function emailExist(Request $request)
    {
        if (User::where('username', $request->username)->first()) {
            return 'false';
        } else {
            return 'true';
        }
    }

    public function regionExist(Request $request) {
        if (Regions::where('name', $request->region_name)->first()) {
            return 'false';
        } else {
            return 'true';
        }
    }

    public function allUsers()
    {
    //    return $users = User::whereRole('practitioner')->paginate(10);
       return $users = User::orderBy('id','asc')->get();
    }

    public function usersOnRegion($region_name) 
    {
        // return $users = User::where('role', 'practitioner')->where('region', $region_name)->paginate();
        return $users = User::whereRole('practitioner')->whereRegion($region_name)->paginate(5);
    }

    public function allAdminUsers()
    {
        return $users = User::orderBy('id', 'desc')->get();
    }
    
    public function getUserWithId($id) 
    {
        $userAvatar = Avatars::where('user_id',$id)->pluck('path');
        $user = User::where('id', $id)->get();
        return response()->json([
            'user_avatar' => $userAvatar,
            'user_info' => $user
        ]);
    }

    public function editUserWithId(Request $request, $id){
        $this->validate($request, [
            'name' => 'required',
            'username' => 'required',
            'role' => 'required',
            'gender' => 'required',
            'id_number' => 'required',
            'serial_number' => 'required',
            'validity_period' => 'required',
            'company' => 'required',
            'region' => 'required',
            'health_status' => 'required'
        ]);

        User::where('id',$id)->update([
            'name' => $request->name,
            'username' => $request->username,
            'role' => $request->role,
            'gender' => $request->gender,
            'id_number' => $request->id_number,
            'serial_number' => $request->serial_number,
            'validity_period' => $request->validity_period,
            'company' => $request->company,
            'region' => $request->region,
            'health_status' => $request->health_status
        ]);

        if($request->comments) {
            User::where('id',$id)->update([
                'comments' => $request->comments
            ]);
        }

        return User::where('id', $id)->get();
    }

    public function setUserRemarkInfo(Request $request) {      
        
        $original_file_path = User::where('id', $request->user_id)->pluck("remark_file")->first();

        if($request->file('user_remark_info')) {
            $file_name = $request->username. "_" . time().'_' . '_'.$request->file('user_remark_info')->getClientOriginalName();
            $file_path = $request->file('user_remark_info')->storeAs('uploads', $file_name, 'public');
            // if($request->remark_file_path) {
            //     File::delete($request->remark_file_path);
            // }
            if($original_file_path == "...") {
                User::where('id',$request->user_id)->update([
                    'remark_file' => '/storage/' . $file_path
                ]);
            } else {
                User::where('id',$request->user_id)->update([
                    'remark_file' => $original_file_path . " , " . '/storage/' . $file_path
                ]);
            }
            return User::where('id', $request->user_id)->pluck("remark_file")->first();
        }
    }

    public function getRegionCompaniesWithId($id) {
        $region = Regions::where('id', $id)->first();
        return response()->json([
            'companies' => $region->companies
        ]);
    }

    public function addNewRegionCompany(Request $request) {
        $regionCompanies = Regions::where('id',$request->region_id)->pluck('companies')->first();
        if($regionCompanies == "") {
            return Regions::where('id',$request->region_id)->update([
                'companies' => $request->company_name
            ]);
        } else {
            return Regions::where('id',$request->region_id)->update([
                'companies' => $regionCompanies . " / " . $request->company_name
            ]);
        }
    }

    public function updateRegionCompany(Request $request) {
        return Regions::where('id', $request->region_id)->update([
            'companies' => $request->companies
        ]);
    }

    public function getRegionCompaniesWithName(Request $request) {
        return $regionCompanies = Regions::where('name', $request->region_name)->pluck("companies")->first();
    }

    public function destroyRegion($id)
    {
        $region = Regions::findOrFail($id);
        $region->delete();
        return $regions = Regions::all();
    }

    public function updateUserPasswordWithId(Request $request, $id) {
        $this->validate($request, [
            'current_password' => 'required',
            'new_password' => 'required',
            'confirm_password' => 'required',
        ]);
        $user_password = User::where('id',$id)->get();
        if(Hash::check($request->current_password, $user_password[0]['password'])) {
            if($request->new_password == $request->confirm_password) {
                return User::where('id',$id)->update([
                    'password' => Hash::make($request->new_password),
                ]);
            } else {
                return 2;
            }
        } else {
            return 3;
        }
    }

    public function keepUserInfo(Request $request, $id) {
        $user_info = User::find($id);
        if($user_info->remark_information == null)
        {
            $user_info->remark_information = $request->info;
        } else {
            $user_info->remark_information .= "/" . $request->info;
        }
        $user_info->save();
        return "User Information has been saved successfully!";
    }

    // New Added

    public function getKeepUserInfo($id) {
        $userKeepInfo = User::where('id',$id)->pluck('remark_information')->first();
        return response()->json([
            'keep_info' => $userKeepInfo
        ]);
    }

    // New Added

    public function addNewRegion(Request $request) {
        $this->validate($request, [
            'region_name' => 'required'
        ]);
        return Regions::create([
            'name' => $request->region_name
        ]);
    }

    public function getRegionIDWithName($name) {
        return $region = Regions::where('name', $name)->pluck("id")->first();
    }

    // New Added

    public function getAllRegions(Request $request) {
        return Regions::orderBy('id','asc')->get();
    }

    public function deleteRemarkInfo(Request $request, $id) {
        if($request->path) {
            File::delete($request->path);
        }
        return User::where('id', $id)->update([
            'remark_file' => $request->remainedFiles
        ]);
    }

    public function destroy($id)
    {
        $user = User::findOrFail($id);
        Avatars::where('user_id', $id)->delete();
        $user->delete();
        return $users = User::all();
    }

    public function allDestroy()
    {
        return User::truncate();
    }
}
