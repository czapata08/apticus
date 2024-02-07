import Image from "next/image";
import {
  CreditCardIcon,
  BarChart2Icon,
  UsersIcon,
  MailIcon,
  DollarSignIcon,
  DatabaseIcon
} from "lucide-react";
import { Balancer } from "react-wrap-balancer";

const features = [
  {
    name: "Effortless Payment Integration",
    description:
      "Leverage the robust infrastructure of Stripe for seamless payment processing. Just provide your Stripe key, and we handle the rest, making transactions smooth and secure.",
    icon: CreditCardIcon,
  },
  {
    name: "Advanced Inventory & Analytics",
    description:
      "Gain insights into your stock levels and product performance with our sophisticated inventory management and analytics tools.",
    icon: BarChart2Icon,
  },
  {
    name: "Intuitive Customer Relationship Management",
    description:
      "Enhance customer engagement with our streamlined CRM, designed to be intuitive and free from unnecessary complexities.",
    icon: UsersIcon,
  },
  {
    name: "Comprehensive Email Solutions",
    description:
      "Elevate your marketing strategies with our integrated email server, perfect for email marketing, invoicing, and more.",
    icon: MailIcon,
  },
  {
    name: "In-Depth Revenue Analytics",
    description:
      "Dive into detailed revenue analytics to understand your financial health and make data-driven decisions.",
    icon: DollarSignIcon,
  },
  {
    name: "AI-Driven Vector Database",
    description:
      "Harness the power of AI with our vector database, offering unparalleled data analysis and pattern recognition.",
    icon: DatabaseIcon,
  },
];


export default function Featuressection() {
  return (
    <div className="">
      <div className="mx-auto max-w-7xl px-6 lg:px-8 mt-20">
        <div className="mx-auto max-w-2xl sm:text-center">
          {/* <h2 className="text-base font-semibold leading-7 text-indigo-600">
            <span className="relative bg-gradient-to-r from-indigo-500 to-purple-500/80 bg-clip-text font-extrabold text-transparent">
              Apticus
            </span>
          </h2> */}

          <h1
            className="animate-fade-up font-sans text-xl font-semibold tracking-tight opacity-0 sm:text-xl md:text-3xl lg:text-4xl p-4 text-center bg-gradient-to-r from-slate-400 via-slate-500 dark:via-slate-400 to-slate-700 dark:to-neutral-300  bg-clip-text text-transparent"
            style={{ animationDelay: "0.25s", animationFillMode: "forwards" }}
          >
            <Balancer>Efficiency is our prime focus</Balancer>
          </h1>

          <p
            className="text-center mt-4 max-w-[42rem] animate-fade-up leading-normal text-muted-foreground opacity-0 sm:text-lg sm:leading-8"
            style={{ animationDelay: "0.35s", animationFillMode: "forwards" }}
          >
            <Balancer>
              Apticus reimagines operations efficiency with a suite of robust and intuitive tools,
              offering a new era of precision and ease in your day-to-day operations.
            </Balancer>
          </p>
        </div>
      </div>
      <div className="relative overflow-hidden pt-16">
        <div className="mx-auto max-w-7xl px-6 lg:px-8">
          <Image
            src="https://tailwindui.com/img/component-images/project-app-screenshot.png"
            alt="App screenshot"
            className="mb-[-12%] rounded-xl shadow-2xl ring-1 ring-gray-900/10"
            width={2432}
            height={1442}
          />
          <div className="relative" aria-hidden="true">
            <div className="absolute -inset-x-20 bottom-0 bg-gradient-to-t from-white pt-[7%]" />
          </div>
        </div>
      </div>
      <div className="mx-auto mt-16 max-w-7xl px-6 sm:mt-20 md:mt-24 lg:px-8">
        <dl className="mx-auto grid max-w-2xl grid-cols-1 gap-x-6 gap-y-10 sm:grid-cols-2 lg:mx-0 lg:max-w-none lg:grid-cols-3 lg:gap-x-8 lg:gap-y-16">
          {features.map((feature) => (
            <div key={feature.name} className="relative pl-9">
              <dt className="inline text-sm font-semibold">
                <feature.icon
                  className="absolute left-1 top-1 h-5 w-5 text-indigo-600"
                  aria-hidden="true"
                />
                <Balancer>{feature.name}</Balancer>
              </dt>
              <dd
                className="mt-2 animate-fade-up leading-normal text-muted-foreground opacity-0"
                style={{
                  animationDelay: "0.35s",
                  animationFillMode: "forwards",
                }}
              >
                <Balancer>{feature.description}</Balancer>
              </dd>
            </div>
          ))}
        </dl>
      </div>
    </div>
  );
}
