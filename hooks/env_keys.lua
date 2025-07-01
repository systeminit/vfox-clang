function PLUGIN:EnvKeys(ctx)
    local mainPath = ctx.path

    -- Helper function to recursively search for libclang.so
    local function find_libclang_so(dir)
        local p = io.popen('find "' .. dir .. '" -type f -name "libclang.so" 2>/dev/null')
        if p then
            local result = p:read("*l")
            p:close()
            return result -- returns first match or nil
        end
        return nil
    end

    local libclang_path = find_libclang_so(mainPath)
    local envs = {
        {
            key = "PATH",
            value = mainPath .. "/bin"
        }
    }

    if libclang_path then
        table.insert(envs, {
            key = "LIBCLANG_PATH",
            value = libclang_path
        })
    end

    return envs
end
