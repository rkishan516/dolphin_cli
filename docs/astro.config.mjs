// @ts-check
import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";
import starlightThemeRapide from "starlight-theme-rapide";

// https://astro.build/config
export default defineConfig({
  site: "https://rkishan516.github.io/dolphin_cli",
  integrations: [
    starlight({
      title: "Dolphin CLI",
      description: "The official command-line interface for the Dolphin framework, tailored for Flutter developers.",
      plugins: [starlightThemeRapide()],
      social: [
        {
          icon: "github",
          label: "GitHub",
          href: "https://github.com/rkishan516/dolphin_cli",
        },
      ],
      logo: {
        src: "./src/assets/logo.svg",
      },
      favicon: "./src/assets/logo.svg",
      head: [
        {
          tag: "meta",
          attrs: {
            name: "keywords",
            content: "dolphin, flutter, cli, framework, dart, mobile development",
          },
        },
      ],
      editLink: {
        baseUrl: "https://github.com/rkishan516/dolphin_cli/edit/main/docs/",
      },
      lastUpdated: true,
      pagination: true,
      tableOfContents: {
        minHeadingLevel: 2,
        maxHeadingLevel: 4,
      },
      sidebar: [
        {
          label: "Getting Started",
          items: [
            { label: "Introduction", slug: "cli/introduction" },
            { label: "Installation", slug: "cli/installation" },
          ],
        },
        {
          label: "CLI Commands",
          collapsed: false,
          items: [
            { label: "create", slug: "cli/commands/create" },
            { label: "bootstrap", slug: "cli/commands/bootstrap" },
            { label: "generate", slug: "cli/commands/generate" },
            { label: "delete", slug: "cli/commands/delete" },
            { label: "upgrade", slug: "cli/commands/upgrade" },
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
