spec_opts_hooks <- function(code_folding) {
  list(
    minidown_hook = gen_hook_code_folding(code_folding_options(code_folding))
  )
}
