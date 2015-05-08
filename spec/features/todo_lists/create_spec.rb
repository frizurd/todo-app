require 'spec_helper'

describe "Creating todo lists" do
  it "redirects to the todo lists index on success" do
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: "My todo list"
    fill_in "Description", with: "This is what I am doing today."
    click_button "Create Todo list"

    expect(page).to have_content("My todo list")
  end

  it "displays an error when the todo list has no title" do
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: ""
    fill_in "Description", with: "This is what I am doing today."
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("This is what I am doing today.")
  end

  it "displays an error when the todo list has a title less than 3 chars" do
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: "Hi"
    fill_in "Description", with: "This is what I am doing today."
    click_button "Create todo list"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("this is what im doing today")
  end

  it "displays an error when the todo list has no description" do
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: "Shopping list"
    fill_in "Description", with: ""
    click_button "Create todo list"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Shopping list")
  end

  it "displays an error when the todo list has no description" do
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: "Shopping list"
    fill_in "Description", with: "Jam"
    click_button "Create todo list"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Shopping list")
  end
end