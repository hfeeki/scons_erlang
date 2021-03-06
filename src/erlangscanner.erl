%% Copyright (C) 2006 José Pablo Ezequiel "Pupeno" Fernández Silva
%%
%% This file is part of SCons Erlang.
%%
%% SCons Erlang is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
%% SCons Erlang is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
%% You should have received a copy of the GNU General Public License along with SCons Erlang; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA
%% Linking SCons Erlang statically or dynamically with other modules is making a combined work based on SCons Erlang. Thus, the terms and conditions of the GNU General Public License cover the whole combination.
%% In addition, as a special exception, the copyright holders of SCons Erlang give you permission to combine SCons Erlang program with code included in the standard release of Erlang/OTP under the Erlang Public Licence (or modified versions of such code, with unchanged license). You may copy and distribute such a system following the terms of the GNU GPL for SCons Erlang and the licenses of the other code concerned, provided that you include the source code of that other code when and as the GNU GPL requires distribution of source code.

%% @author José Pablo Ezequiel "Pupeno" Fernández Silva <pupeno@pupeno.com> [http://pupeno.com]
%% @copyright 2006 José Pablo Ezequiel "Pupeno" Fernández Silva

-module(erlangscanner).
-export([app_needed_by_rel/1, mod_needed_by_app/1, erlang_dir/0]).

app_needed_by_rel([File]) ->
    {ok, {_,_,_,Applications}} = file:script(File),
    print_list(application_names(Applications)).


application_names([]) ->
    [];
application_names([{ApplicationName,_}|Applications]) ->
    [ApplicationName | application_names(Applications)].



mod_needed_by_app([File]) ->
    {ok, {_, _, MetaData}} = file:script(File),
    print_list(module_names(MetaData)).


module_names([]) ->
    [];
module_names([{modules, ModuleNames}|_]) ->
    ModuleNames;
module_names([_|MetaData]) ->
    module_names(MetaData).



erlang_dir() ->
    io:fwrite("~s~n", [code:root_dir()]).


print_list([]) ->
    ok;
print_list([Name|Modules]) ->
    io:fwrite("~w~n", [Name]),
    print_list(Modules).
