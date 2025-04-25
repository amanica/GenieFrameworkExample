# Copilot-Instructions.md

# Copilot Instructions for GenieFrameworkExample

## Best Practices for Julia Genie and Stipple

### Project Structure
- **Main Module**: The main module is located in `src/GenieFrameworkExample.jl`.
- **Submodules**: Submodules for different Stipple app contexts are located in `src/users` and `src/simulations`.

### Reactive UI Design
- Use the `@app` macro to define reactive code blocks.
- Define reactive variables with `@in` (modifiable from the UI) and `@out` (read-only).
- Use `@onchange` to handle changes in reactive variables, ensuring UI updates are triggered correctly.

### UI Layout and Components
- Define UI layouts and components in Julia using the low-code API or in HTML for more flexibility.
- Use functions like `cell`, `row`, and `column` to structure layouts.
- Leverage Stipple's extensive library of UI components (e.g., `textfield`, `slider`, `bignumber`) for interactive elements.

### Routing
- Use the `@page` macro to define routes that map to specific UI functions or HTML files.
- For example, `@page("/", ui)` maps the root route to the `ui` function.

### Environment Setup
- Use `@genietools` to configure assets like JavaScript, icons, and fonts.
- Ensure the Genie development environment is set up with `Genie.loadapp()` and `up()` to start the server.

### Modularity
- Include submodules in the main module using `include` statements.
- Export only necessary symbols to keep the API clean.

### Development Workflow
- Make use of Genie’s hot-reloading feature to see changes in real-time without restarting the server.
- Organize configuration files (e.g., `dev.jl`, `prod.jl`) under a `config` directory for different environments.

### Database Integration
- Use the `db` folder for database-related files like migrations, seeds, and connection configurations.
- Keep database logic separate from the UI and routing logic.

### Example Workflow
1. **Start the App**:
   ```bash
   julia --project
   using GenieFramework
   Genie.loadapp()
   up()
   ```
2. **Modify Submodules**:
   - Add or update functionality in `src/users` or `src/simulations`.
3. **Test Changes**:
   - Use Genie’s hot-reloading to test changes without restarting the server.

### Notes
- This project deviates from the default Genie structure by placing the main module in `src` and using submodules for different Stipple app contexts.
- Ensure all submodules are properly included and exported in the main module.

---

For more details, refer to the [Genie Framework Documentation](https://learn.genieframework.com/framework)
and [Genie Framework on Github](https://github.com/GenieFramework)

https://github.com/GenieFramework/SearchLight.jl