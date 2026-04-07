; extends

((attribute
  (attribute_name) @attr_name
  (quoted_attribute_value
    (attribute_value) @injection.content))
  (#match? @attr_name "^(x-|\\@|:)")
  (#set! injection.language "javascript"))
