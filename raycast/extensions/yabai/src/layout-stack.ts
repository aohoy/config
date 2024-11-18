import { showHUD } from "@raycast/api";
import { runYabaiCommand } from "./helpers/scripts";
import { showFailureToast } from "@raycast/utils";

export default async function Command() {
  try {
    const { stderr } = await runYabaiCommand("-m space --layout stack");

    if (stderr) {
      throw new Error();
    }

    showHUD("Switched to stack layout");
  } catch (error) {
    if (error instanceof Error && error.message.includes("Yabai executable not found")) {
      return;
    }

    showFailureToast(error, {
      title: "Failed to switch to stack layout, make sure you have Yabai installed and running.",
    });
  }
}
