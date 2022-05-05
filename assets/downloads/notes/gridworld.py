import numpy as np
import matplotlib.pyplot as plt

ROWS, COLS = 4, 4
TERMINATION = [[0, 0], [ROWS-1, COLS-1]]


class Game:

    def __init__(self, plays=10):
        self.values = np.zeros((ROWS, COLS))
        self.tempValues = np.zeros((ROWS, COLS))
        self.states = [[i, j] for i in range(ROWS) for j in range(COLS)]
        self.actions = [[-1,0], [1,0], [0,-1], [0,1]]
        self.deltas = np.array((ROWS, COLS))
        self.rewardSize = -1
        self.gamma = 1
        self.plays = plays
        self.epsilon = 1e-3
        self.stopEarly = True

    def nextAction(self, initialPos, action):
        if initialPos in TERMINATION:
            return initialPos, 0
        finalPos = np.array(initialPos) + np.array(action)
        if (-1 in finalPos) or (ROWS in finalPos) or (COLS in finalPos):
            finalPos = initialPos
        reward = self.rewardSize
        return finalPos, reward

    def policyEval(self):
        self.deltas = []
        for i in range(self.plays):
            self.stopEarly = True
            deltaState = []
            for state in self.states:
                tempReward = 0
                for action in self.actions:
                    finalPos, reward = self.nextAction(state, action)
                    tempReward += (1/len(self.actions)) * (reward + self.gamma*self.values[finalPos[0], finalPos[1]])
                deltaState.append((np.abs(self.tempValues[state[0], [state[1]]] - tempReward)[0]))
                self.tempValues[state[0], state[1]] = tempReward
            # updating
            self.values = self.tempValues
            self.deltas.append(deltaState)
            if i in [0, 1, 99, self.plays-1]:
                print(f'Iteration {i+1}')
                print(self.values)
                print('')
            # early stop if converged
            for delta in deltaState:
                if delta > self.epsilon:
                    self.stopEarly = False
            if (self.stopEarly is True) and i > 0:
                print(f'last iteration: {i+1}')
                break


if __name__ == '__main__':
    game = Game(1000)
    game.policyEval()
    # cell = 0  # cell to investigate convergence
    # plt.plot(np.array(game.deltas)[:, cell])
    plt.plot(game.deltas)
    plt.show()
