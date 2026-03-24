import re
from selectors import SelectSelector

from playwright.sync_api import Playwright, sync_playwright, expect, Page


def run(playwright: Playwright) -> None:
    browser = playwright.chromium.launch(headless=False)
    context = browser.new_context()
    page1 = context.new_page()
    page1.goto("https://wp.rc.gospodaprogrammisty.ru/login")
    page1.locator("input[type=\"email\"]").click()
    page1.locator("input[type=\"email\"]").fill("a.shakirov@smartway.today")
    page1.locator("input[type=\"password\"]").click()
    page1.locator("input[type=\"password\"]").fill("Saboteur6")
    page1.get_by_role("button", name="Войти").click()
    page1.locator("#search-box").get_by_role("link", name="Гостиницы").click()
    page1.locator(".index-module__wrapper___IAI4E").click()
    page1.get_by_role("textbox", name="Город или гостиница").click()
    page1.get_by_role("textbox", name="Город или гостиница").fill("Самара")
    page1.get_by_text("СамараРоссия").first.click()
    page1.locator("div").filter(has_text=re.compile(r"^16$")).first.click()
    page1.get_by_text("19", exact=True).click()
    page1.get_by_role("button", name="Найти").click()
    page1.wait_for_timeout(5000)
    expect(page1.get_by_text("Корпоративный тариф:").nth(1)).to_be_visible()
    page1.wait_for_timeout(5000)
    print("✅ Есть 3D рейты")
    page1.screenshot(path="hotel_with_offline.png")


    context.close()
    browser.close()


with sync_playwright() as playwright:
    run(playwright)
