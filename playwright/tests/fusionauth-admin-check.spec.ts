import { test, expect } from '@playwright/test';

test('fusionauth-admin-check', async ({ page }) => {
  await page.goto(process.env.FUSIONAUTH_ADMIN_URL ?? 'http://localhost:9011/admin/');
  await page.getByPlaceholder('Email').click();
  await page.getByPlaceholder('Email').fill('admin@example.com');
  await page.getByPlaceholder('Password').click();
  await page.getByPlaceholder('Password').fill('password');
  await page.getByRole('button', { name: 'Submit' }).click();
  await page.waitForLoadState();
  await page.locator('a[href="/admin/application/"]').click();
  await page.waitForLoadState();
  await page.getByRole('row', { name: 'Example Application ' }).getByRole('button').click();
  await page.getByRole('link', { name: 'Edit' }).click();
  await page.waitForLoadState();
  expect(await page.textContent('body')).toContain('http://localhost:3000');
  await page.locator('a[href="/admin/user/"]').click();
  await page.waitForLoadState();
  await page.getByRole('textbox', { name: 'Search on email, name or role' }).click();
  await page.getByRole('textbox', { name: 'Search on email, name or role' }).fill('richard');
  await page.getByRole('button', { name: 'Search' }).click();
  await page.waitForResponse(response => response.url().includes('ajax/user/search') && response.status() === 200);
  expect(await page.textContent('body')).toContain('richard@example.com');
  await page.getByRole('link', { name: 'Logout' }).click();
});
