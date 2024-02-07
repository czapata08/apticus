import { env } from "@/env.mjs";
import { SiteConfig } from "types"

const site_url = env.NEXT_PUBLIC_APP_URL;

export const siteConfig: SiteConfig = {
  name: "Apticus",
  description:
    "Simplified Operation Management Platform Focused On The Needs Of The Modern Business",
  url: site_url,
  ogImage: `${site_url}/og.jpg`,
  links: {
    twitter: "https://twitter.com/apticus",
    github: "https://github.com/czapata08",
  },
  mailSupport: "czapata@studentflow.io"
}
