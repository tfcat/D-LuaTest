import std.stdio;
import derelict.lua.lua;

void main()
{
	DerelictLua.load();

	// create vm
	lua_State* L = luaL_newstate();

	// Allow "print" function, defined in D to be 
	// called in Lua scripts
	lua_register(L, "print", cast(lua_CFunction)&print);

	// Run the script
	printf("Running LUA\n===========================\n");
	int ret = luaL_dofile(L, cast(char*)"test.lua");
	printf("\n===========================\n");

	if(ret == 0) {
		printf("Success!");
	}else{
		printf("Error: %s", lua_tostring(L,-1));	
	}

	lua_close(L);
}

void print(lua_State *L) {
	//number of args
	int n = lua_gettop(L);
	//for each argument, print
	for (int i = 1; i <= n; i++)
	{
		//pop arg from stack and print
		printf(lua_tostring(L, i));
	}
}