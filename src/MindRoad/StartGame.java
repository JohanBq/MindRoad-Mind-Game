package MindRoad;

/**
 * Created by robkr on 2014-09-30.
 */
public class StartGame {
    public void start() {
        GameRules gr = new GameRules(4,7);
        gr.startGame();
    }
}
