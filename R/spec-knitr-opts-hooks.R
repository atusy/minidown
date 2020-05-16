spec_opts_hooks <- function(code_folding) {
  folding <- fold(code_folding)
  list(
    class.source = hook_code_class("source", folding["source"]),
    class.output = hook_code_class("output", folding["output"]),
    class.message = hook_code_class("message", folding["message"]),
    class.warning = hook_code_class("warning", folding["warning"]),
    class.error = hook_code_class("error", folding["error"])
  )
}
