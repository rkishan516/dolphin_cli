// @ts-check
import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";

// https://astro.build/config
export default defineConfig({
  integrations: [
    starlight({
      title: "Dolphin docs",
      social: {
        github: "https://github.com/rkishan516/dolphin_cli",
      },
      logo: {
        src: "./src/assets/logo.svg",
      },
      sidebar: [
        {
          label: "Dolphin CLI",
          items: [
            // Each item here is one entry in the navigation menu.
            { label: "Introduction", slug: "cli/introduction" },
            { label: "Installation", slug: "cli/installation" },
            {
              label: "CLI Commands",
              items: [
                { label: "Create", slug: "cli/commands/create" },
                { label: "Bootstrap", slug: "cli/commands/bootstrap" },
                { label: "Delete", slug: "cli/commands/delete" },
                { label: "Generate", slug: "cli/commands/generate" },
                { label: "Upgrade", slug: "cli/commands/upgrade" },
              ],
            },
          ],
        },
        {
          label: "Dolphin Framework",
          slug: "framework/introduction",
        },
      ],
    }),
  ],
});
