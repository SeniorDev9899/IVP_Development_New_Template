<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/


Route::group(['prefix' => 'auth'], function () {
    Route::post('login','AuthController@authenticate');
    Route::post('register','AuthController@store');
    Route::get('logout','AuthController@logout');
    Route::get('check','AuthController@check');
    Route::group(['prefix' => 'new'], function () {
        Route::post('/register', [
            'as' => 'auth.new.register', 'uses' => 'AuthController@newMemberAdd'
        ]);
    });
    Route::group(['prefix' => 'update'], function () {
        Route::post('/verification', [
            'as' => 'auth.update.verification', 'uses' => 'AuthController@updateUserEmailVerification'
        ]);
    });
    Route::group(['prefix' => 'resend'], function () {
        Route::post('/verification', [
            'as' => 'auth.resend.verification', 'uses' => 'AuthController@resendEmailVerification'
        ]);
    });
    Route::group(['prefix' => 'password'], function () {
        Route::post('/reset', [
            'as' => 'auth.password.reset', 'uses' => 'AuthController@passwordReset'
        ]);
    });
    Route::group(['prefix' => 'user'], function () {
        Route::post('/updatePassword/{id}', [
            'as' => 'auth.user.updatePassword', 'uses' => 'AuthController@updateUserPasswordWithId'
        ]);
    });
});

// session route
Route::post('email-exist',[
    'as' => 'email-exist','uses' => 'Demo\PagesController@emailExist'
]);

Route::get('/get/allAdminUsers', [
    'as' => 'admin.users.all', 'uses' => 'Demo\PagesController@allAdminUsers' 
]);

// admin route
Route::group(['prefix' => 'admin', 'middleware' => 'api.auth'], function (){

    Route::resource('todos', 'Demo\TodosController');

    Route::post('todos/toggleTodo/{id}', [
        'as' => 'admin.todos.toggle', 'uses' => 'Demo\TodosController@toggleTodo'
    ]);

    Route::group(['prefix' => 'settings'], function () {

        Route::post('/social', [
            'as' => 'admin.settings.social', 'uses' => 'Demo\SettingsController@postSocial'
        ]);
    });

    Route::group(['prefix' => 'users'], function (){

        Route::get('/get',[
            'as' => 'admin.users', 'uses' => 'Demo\PagesController@allUsers'
        ]);

        Route::get('/get/{region_name}', [
            'as' => 'admin.users.onRegion', 'uses' => 'Demo\PagesController@usersOnRegion'
        ]);

        Route::delete('/{id}',[
            'as' => 'admin.users.delete', 'uses' => 'Demo\PagesController@destroy'
        ]);

        Route::delete('/all', [
            'as' => 'admin.users.all.delete', 'uses' => 'Demo\PagesController@allDestroy'
        ]);

    });

    Route::group(['prefix' => 'user'], function (){

        Route::get('/get/{id}',[
            'as' => 'admin.user', 'uses' => 'Demo\PagesController@getUserWithId'
        ]);        

        Route::post('/edit/{id}', [
            'as' => 'admin.user.edit', 'uses' => 'Demo\PagesController@editUserWithId'
        ]);

        Route::post('/changeUserAvatar', [
            'as' => 'admin.user.change.avatar', 'uses' => 'AvatarsController@changeUserAvatar'
        ]);

        Route::post('/updatePassword/{id}', [
            'as' => 'admin.user.updatePassword', 'uses' => 'Demo\PagesController@updateUserPasswordWithId'
        ]);

        Route::group(['prefix' => 'avatar'], function (){
            Route::get('/get/{id}', [
                'as' => 'admin.user.avatar', 'uses' => 'AvatarsController@getUserAvatarWithId'
            ]);
            Route::get('/getAll', [
                'as' => 'admin.user.avatar.getall', 'uses' => 'AvatarsController@getAllAvatars'
            ]);
        });        

        Route::post('/keep/{id}', [
            'as' => 'admin.user.keep', 'uses' => 'Demo\PagesController@keepUserInfo'
        ]);

        // New Added

        Route::get('/get/keepInfo/{id}', [
            'as' => 'admin.user.get.keepInfo', 'uses' => 'Demo\PagesController@getKeepUserInfo'
        ]);

    });

    // New Added 
    Route::group(['prefix' => 'region'], function () {
        Route::post('/add/new', [
            'as' => 'admin.region.add.new', 'uses' => 'Demo\PagesController@addNewRegion'
        ]);
        Route::get('/get/all', [
            'as' => 'admin.region.get.all', 'uses' => 'Demo\PagesController@getAllRegions'
        ]);
    });

});

