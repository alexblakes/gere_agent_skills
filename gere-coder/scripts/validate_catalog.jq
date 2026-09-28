.[0] as $catalog
| .[1] as $index
| ($catalog.entries | length) as $count
| if ($index.entry_count != $count) then error("index entry count mismatch") else . end
| if (([$catalog.entries[].id] | unique | length) != $count) then error("duplicate entry id") else . end
| if (all($catalog.entries[];
    has("id") and has("programme") and has("release") and has("category")
    and has("entry_type") and has("name") and has("description")
    and has("formats") and has("keywords") and has("paths")
    and has("availability") and has("example_filepath")
    and has("path_precision") and has("source_urls")
    and (.description | length) < 80
    and (.example_filepath | length) > 0
    and (.keywords | length) > 0
    and all(.source_urls[]; startswith("https://"))
    and (
      (.programme == "100kgp" and .release == "v19")
      or (.programme == "gms" and .release == "v5")
      or (.programme == "covid" and .release == "v7")
      or (.programme == "cross-programme" and .release == "current")
    )
  ) | not) then error("catalog invariant failed") else . end
| if (all(($catalog.entries | to_entries)[];
    $index.id_to_offset[.value.id] == .key
  ) | not) then error("index offset mismatch") else . end
| {validated_entries: $count}
