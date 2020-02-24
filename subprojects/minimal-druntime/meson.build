project('Minimal druntime', 'd')

sources = files(
    'src/core/exception.d',
    'src/core/internal/entrypoint.d',
    'src/object.d',
    #'src/rt/deh.d',
    #'src/rt/dmain2.d',
    #'src/rt/memory.d',
    #'src/rt/sections.d',
    #'minimal-phobos/core/stdc/config.d',
)

druntime_dep = declare_dependency(
    sources: sources,
    include_directories: ['src'],
)
