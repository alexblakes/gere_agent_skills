def arg($name): $ARGS.named[$name] // "";
def available_key($name):
  if $name == "hpc" then "hpc_filesystem"
  elif $name == "cloudos" then "cloudos"
  elif $name == "labkey" then "labkey"
  else "" end;

(arg("id") | ascii_downcase) as $id
| (arg("programme") | ascii_downcase) as $programme
| (arg("release") | ascii_downcase) as $release
| (arg("category") | ascii_downcase) as $category
| (arg("description") | ascii_downcase) as $description
| (arg("format") | ascii_downcase) as $format
| (arg("path_kind") | ascii_downcase) as $path_kind
| (arg("available_in") | ascii_downcase) as $available_in
| (arg("keywords") | ascii_downcase | split(",") | map(select(length > 0))) as $terms
| (arg("limit") | tonumber? // 50) as $limit
| (arg("full") == "true") as $full
| .entries
| map(
    ([.id, .name, .description, .category] + .keywords + .key_fields + .formats
      | join(" ") | ascii_downcase) as $haystack
    | select($id == "" or (.id | ascii_downcase) == $id)
    | select($programme == "" or (.programme | ascii_downcase) == $programme)
    | select($release == "" or (.release | ascii_downcase) == $release)
    | select($category == "" or (.category | ascii_downcase | contains($category)))
    | select($description == "" or (.description | ascii_downcase | contains($description)))
    | select($format == "" or any(.formats[]; ascii_downcase == $format))
    | select(all($terms[]; . as $term | $haystack | contains($term)))
    | select(
        $path_kind == ""
        or ($path_kind == "hpc" and (.paths.hpc | length) > 0)
        or ($path_kind == "s3" and (.paths.s3 | length) > 0)
        or ($path_kind == "labkey" and .labkey != null)
      )
    | select(
        $available_in == ""
        or .availability[available_key($available_in)] == "available"
      )
    | if $full then . else
        {id, formats, paths, example_filepath}
      end
  )
| .[:$limit]
