/*
  Warnings:

  - You are about to drop the column `emailVerified` on the `users` table. All the data in the column will be lost.

*/
-- CreateEnum
CREATE TYPE "public"."workspace_plans" AS ENUM ('TRIAL', 'BASE_PLAN', 'PRO', 'ENTERPRISE', 'INVENTORY', 'RESTAURANT');

-- CreateEnum
CREATE TYPE "public"."roles_names" AS ENUM ('ADMIN', 'TEAM_ADMIN', 'TEAM_BASE');

-- CreateEnum
CREATE TYPE "public"."database_actions" AS ENUM ('CREATE', 'READ', 'UPDATE', 'DELETE');

-- AlterTable
ALTER TABLE "public"."users" DROP COLUMN "emailVerified",
ADD COLUMN     "email_verified" TIMESTAMP(3),
ADD COLUMN     "onboarding_email_sent" BOOLEAN NOT NULL DEFAULT false;

-- CreateTable
CREATE TABLE "public"."workspaces" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "address" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "zip" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "primary_contact" TEXT NOT NULL,
    "team_members_quota" INTEGER DEFAULT 5,
    "tables_quota" INTEGER DEFAULT 5,
    "plan" "public"."workspace_plans" DEFAULT 'BASE_PLAN',
    "stripe_subscription_id" TEXT,

    CONSTRAINT "workspaces_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."WorkspaceTeamMember" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT NOT NULL,
    "workspace_id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "is_workspace_admin" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "WorkspaceTeamMember_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."workspace_roles" (
    "id" TEXT NOT NULL,
    "name" "public"."roles_names" NOT NULL DEFAULT 'TEAM_BASE',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "workspace_id" TEXT NOT NULL,

    CONSTRAINT "workspace_roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."roles_permissions" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "role_id" TEXT NOT NULL,
    "is_workspace_admin" BOOLEAN NOT NULL DEFAULT false,
    "table_name" TEXT NOT NULL,
    "actions" "public"."database_actions"[],

    CONSTRAINT "roles_permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."roles_to_permissions" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "assignedBy" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "role_id" TEXT NOT NULL,

    CONSTRAINT "roles_to_permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."workspace_logs" (
    "id" TEXT NOT NULL,
    "workspace_id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "log" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "workspace_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."workspace_team_user_invites" (
    "id" TEXT NOT NULL,
    "workspace_id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "role_type" TEXT NOT NULL,
    "email_confirmed" BOOLEAN NOT NULL DEFAULT false,
    "on_boarding_completed" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "workspace_team_user_invites_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."workspace_user_notifications" (
    "id" TEXT NOT NULL,
    "workspace_id" TEXT NOT NULL,
    "table_id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "email" BOOLEAN NOT NULL DEFAULT true,
    "sms" BOOLEAN NOT NULL DEFAULT false,
    "push" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "workspace_user_notifications_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "workspaces_name_key" ON "public"."workspaces"("name");

-- CreateIndex
CREATE UNIQUE INDEX "workspaces_stripe_subscription_id_key" ON "public"."workspaces"("stripe_subscription_id");

-- CreateIndex
CREATE UNIQUE INDEX "roles_to_permissions_user_id_key" ON "public"."roles_to_permissions"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "workspace_team_user_invites_workspace_id_user_id_key" ON "public"."workspace_team_user_invites"("workspace_id", "user_id");

-- CreateIndex
CREATE UNIQUE INDEX "workspace_user_notifications_workspace_id_user_id_key" ON "public"."workspace_user_notifications"("workspace_id", "user_id");

-- AddForeignKey
ALTER TABLE "public"."WorkspaceTeamMember" ADD CONSTRAINT "WorkspaceTeamMember_workspace_id_fkey" FOREIGN KEY ("workspace_id") REFERENCES "public"."workspaces"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."WorkspaceTeamMember" ADD CONSTRAINT "WorkspaceTeamMember_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."workspace_roles" ADD CONSTRAINT "workspace_roles_workspace_id_fkey" FOREIGN KEY ("workspace_id") REFERENCES "public"."workspaces"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."roles_permissions" ADD CONSTRAINT "roles_permissions_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "public"."workspace_roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."roles_to_permissions" ADD CONSTRAINT "roles_to_permissions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."WorkspaceTeamMember"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
