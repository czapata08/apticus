import "@/styles/globals.css";

import { fontHeading, fontSans, fontUrban, fontLogo } from "@/assets/fonts";
import { Analytics } from "@/components/analytics";
import { ModalProvider } from "@/components/modal-provider";
import { ThemeProvider } from "@/components/providers";
import { TailwindIndicator } from "@/components/tailwind-indicator";
import { Toaster } from "@/components/ui/toaster";
import { siteConfig } from "@/config/site";
import { cn } from "@/lib/utils";

interface RootLayoutProps {
  children: React.ReactNode
}

export const metadata = {
  title: {
    default: siteConfig.name,
    template: `%s | ${siteConfig.name}`,
  },
  description: siteConfig.description,
  keywords: [
    "Operations Management Software", "Business Process Automation", "Workflow Optimization",
    "Efficiency Tools", "Enterprise Resource Planning (ERP)", "Project Management Solutions",
    "Data Analytics for Business", "Supply Chain Management", "Inventory Tracking Software",
    "Task Management System", "Business Intelligence Tools", "Performance Management Software",
    "Customer Relationship Management (CRM)", "Financial Management System",
    "Human Resources Management System (HRMS)", "Content Management System (CMS)",
    "Cloud-Based Business Solutions", "SME Business Tools", "Corporate Operations Software",
    "Digital Transformation in Business",
  ],
  authors: [
    {
      name: "Apticus Inc",
    },
  ],
  creator: "Carlos Zapata",
  metadataBase: new URL(siteConfig.url),
  openGraph: {
    type: "website",
    locale: "en_US",
    url: siteConfig.url,
    title: siteConfig.name,
    description: siteConfig.description,
    siteName: siteConfig.name,
  },
  twitter: {
    card: "summary_large_image",
    title: siteConfig.name,
    description: siteConfig.description,
    images: [siteConfig.ogImage],
    creator: "@apticus",
  },
  icons: {
    icon: "/favicon.ico",
    shortcut: "/icon-slate-600.png",
    apple: "/apple-touch-icon.png",
  },
  manifest: `${siteConfig.url}/site.webmanifest`,
}

export default function RootLayout({ children }: RootLayoutProps) {

  return (
    <html lang="en" suppressHydrationWarning>
      <head />
      <body
        className={cn(
          "min-h-screen bg-background font-sans antialiased",
          fontSans.variable,
          fontUrban.variable,
          fontHeading.variable,
          fontLogo.variable
        )}
      >
        <ThemeProvider attribute="class" defaultTheme="system" enableSystem disableTransitionOnChange>
          {children}
          <Analytics />
          <Toaster />
          <ModalProvider />
          <TailwindIndicator />
        </ThemeProvider>
      </body>
    </html>
  )
}
