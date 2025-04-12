# export app_page, app_layout

# function app_layout(module_::Module)
#     # @show model = @init(module_)
#     return function()
#         moduleInfo = :MODULE_INFO ∈ names(module_; all=true) ? module_.MODULE_INFO : ""
#         model = @init(module_)
#         page(model, [
#                 h1(APP_NAME),
#                 "<% @yield %>",
#                 pre(moduleInfo)
#             ];
#             title = APP_NAME
#         )
#     end
# end

# # function app_layout(module_::Module)
# #     @show model = @init(module_)
# #     app_layout(model, module_)
# # end
# moduleInfo = :MODULE_INFO ∈ names(@__MODULE__; all=true) ? (@__MODULE__).MODULE_INFO : ""
# moduleInfo = ""
page(model, [
            h1(APP_NAME),
            @yield,
            pre(MODULE_INFO)
        ];
        title = APP_NAME
        ,partial = false)

