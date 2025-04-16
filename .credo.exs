%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["mix.exs"],
        excluded: [
          "*/test/support",
          "*/lib/mix/tasks",
          "*/priv/templates/phx.gen.schema"
        ]
      },
      checks: [
        {Credo.Check.Refactor.MapInto, false},
        {Credo.Check.Warning.LazyLogging, false},
        {Credo.Check.Consistency.TabsOrSpaces},
        {Credo.Check.Readability.MaxLineLength, priority: :low, max_length: 180},
        {Credo.Check.Readability.ModuleDoc,
         files: %{
           included: ["apps/"],
           excluded: [
             "**/*.exs",
             "*/priv/",
             "*/test/",
             "**/release.ex",
             "**/telemetry.ex",
             "**/application.ex",
             "**/*_view.ex",
             "**/*_web.ex",
             "**/*_helpers.ex"
           ]
         }},
        {
          Credo.Check.Readability.Specs,
          files: %{
            included: ["apps/"],
            excluded: [
              "**/*.exs",
              "*/tasks/",
              "*/priv/",
              "*/test/",
              "**/release.ex",
              "**/telemetry.ex",
              "**/application.ex",
              "**/*_view.ex",
              "**/*_web.ex",
              "**/*_helpers.ex",
              "**/components/core_components.ex"
            ]
          }
        }
      ]
    }
  ]
}
