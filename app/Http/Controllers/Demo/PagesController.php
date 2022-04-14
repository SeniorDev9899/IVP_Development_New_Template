<?php
namespace App\Http\Controllers\Demo;

use App\User;
use App\Avatars;    

// New Added

use App\Regions;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;

class PagesController extends Controller
{
    public function emailExist(Request $request)
    {
        if (User::whereEmail($request->email)->first()) {
            return 'false';
        } else {
            return 'true';
        }
    }

    public function allUsers()
    {
    //    return $users = User::whereRole('practitioner')->paginate(10);
       return $users = User::orderBy('id','desc')->paginate(5);
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
            'first_name' => 'required',
            'last_name' => 'required',
            'email' => 'required|email',
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
            'first_name' => $request->first_name,
            'last_name' => $request->last_name,
            'email' => $request->email,
            'role' => $request->role,
            'gender' => $request->gender,
            'id_number' => $request->id_number,
            'serial_number' => $request->serial_number,
            'validity_period' => $request->validity_period,
            'company' => $request->company,
            'region' => $request->region,
            'health_status' => $request->health_status
        ]);
        return User::where('id', $id)->get();
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

    // New Added

    public function getAllRegions(Request $request) {
        return Regions::orderBy('id','asc')->get();
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
