

import { DashboardHeader } from "@/components/dashboard/header";
import { DashboardShell } from "@/components/dashboard/shell";


export default function PropertyPage(props: { params: { slug: string } }) {
  //change this to true to test
  const hasPhoto = false;


  if (!hasPhoto) {
    return (
      <DashboardShell>
        <DashboardHeader
          heading="{Address_name}"
          text="Lets start working on your property"
        ></DashboardHeader>
        <div>

        </div>
      </DashboardShell>
    );
  }

  return (
    <DashboardShell>
      <DashboardHeader
        heading="{Address_name}"
        text="Lets start working on your property"
      ></DashboardHeader>
      <div>

      </div>
    </DashboardShell>
  );
}
