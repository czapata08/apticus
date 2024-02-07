/*
  Warnings:

  - You are about to drop the column `onboarding_email_sent` on the `users` table. All the data in the column will be lost.
  - You are about to drop the `workspace_team_user_invites` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `workspace_user_notifications` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "public"."notification_types" AS ENUM ('INVENTORY_INPUT', 'INVENTORY_OUTPUT', 'INVENTORY_ADJUSTMENT', 'INVENTORY_LOW_STOCK', 'PENDING_INPUT', 'PENDING_OUTPUT', 'PENDING_ADJUSTMENT', 'PRICE_ADJUSTMENT', 'PAYMENT_PROCESSED', 'PAYMENT_FAILED', 'PAYMENT_REFUNDED', 'NEW_ORDER', 'ORDER_CANCELLED', 'NEW_EVENT_CREATED', 'NEW_PRODUCT_CREATED', 'NEW_CUSTOMER_CREATED');

-- CreateEnum
CREATE TYPE "public"."notification_type" AS ENUM ('EMAIL', 'SMS', 'PUSH');

-- CreateEnum
CREATE TYPE "public"."notification_status" AS ENUM ('SENT', 'PENDING', 'FAILED');

-- AlterTable
ALTER TABLE "public"."users" DROP COLUMN "onboarding_email_sent";

-- DropTable
DROP TABLE "public"."workspace_team_user_invites";

-- DropTable
DROP TABLE "public"."workspace_user_notifications";

-- CreateTable
CREATE TABLE "public"."workspace_tables" (
    "id" TEXT NOT NULL,
    "workspace_id" TEXT NOT NULL,
    "table_name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT NOT NULL,

    CONSTRAINT "workspace_tables_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."ws_team_invites" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "invited_by" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "role_Id" "public"."roles_names" NOT NULL,
    "email_confirmed" BOOLEAN NOT NULL DEFAULT false,
    "on_boarding_completed" BOOLEAN NOT NULL DEFAULT false,
    "workspace_id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,

    CONSTRAINT "ws_team_invites_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."user_notifications" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "workspace_id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,

    CONSTRAINT "user_notifications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."notification_preferences" (
    "id" TEXT NOT NULL,
    "userNotificationId" TEXT NOT NULL,
    "notification_type" "public"."notification_types" NOT NULL,
    "medium" "public"."notification_type" NOT NULL DEFAULT 'EMAIL',
    "isSubscribed" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "notification_preferences_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "workspace_tables_workspace_id_table_name_idx" ON "public"."workspace_tables"("workspace_id", "table_name");

-- CreateIndex
CREATE UNIQUE INDEX "workspace_tables_workspace_id_table_name_key" ON "public"."workspace_tables"("workspace_id", "table_name");

-- CreateIndex
CREATE UNIQUE INDEX "ws_team_invites_workspace_id_user_id_key" ON "public"."ws_team_invites"("workspace_id", "user_id");

-- CreateIndex
CREATE INDEX "user_notifications_workspace_id_user_id_idx" ON "public"."user_notifications"("workspace_id", "user_id");

-- CreateIndex
CREATE UNIQUE INDEX "user_notifications_workspace_id_user_id_key" ON "public"."user_notifications"("workspace_id", "user_id");

-- CreateIndex
CREATE UNIQUE INDEX "notification_preferences_userNotificationId_notification_ty_key" ON "public"."notification_preferences"("userNotificationId", "notification_type", "medium");

-- CreateIndex
CREATE INDEX "WorkspaceTeamMember_workspace_id_user_id_idx" ON "public"."WorkspaceTeamMember"("workspace_id", "user_id");

-- CreateIndex
CREATE INDEX "workspace_logs_workspace_id_user_id_idx" ON "public"."workspace_logs"("workspace_id", "user_id");

-- CreateIndex
CREATE INDEX "workspace_roles_workspace_id_idx" ON "public"."workspace_roles"("workspace_id");

-- CreateIndex
CREATE INDEX "workspaces_name_idx" ON "public"."workspaces"("name");

-- AddForeignKey
ALTER TABLE "public"."workspace_tables" ADD CONSTRAINT "workspace_tables_workspace_id_fkey" FOREIGN KEY ("workspace_id") REFERENCES "public"."workspaces"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ws_team_invites" ADD CONSTRAINT "ws_team_invites_workspace_id_fkey" FOREIGN KEY ("workspace_id") REFERENCES "public"."workspaces"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ws_team_invites" ADD CONSTRAINT "ws_team_invites_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."user_notifications" ADD CONSTRAINT "user_notifications_workspace_id_fkey" FOREIGN KEY ("workspace_id") REFERENCES "public"."workspaces"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."user_notifications" ADD CONSTRAINT "user_notifications_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."notification_preferences" ADD CONSTRAINT "notification_preferences_userNotificationId_fkey" FOREIGN KEY ("userNotificationId") REFERENCES "public"."user_notifications"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
