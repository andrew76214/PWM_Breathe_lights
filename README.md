# PWM_Breathe_lights
## 原理架構圖
 - **原理架構**：目標功能為產生三種不同頻率的呼吸燈
 ![image](https://user-images.githubusercontent.com/61071600/173220783-43f24d48-1db1-46de-9cc3-502b8f3daf49.png)
 - **Counter產生**:建立一個 counter，並取用 q 不同的 bit 組成 A (counter1)、B (counter2)
![image](https://user-images.githubusercontent.com/61071600/173220832-4ccabf22-a58c-4152-9f58-6af101ff2678.png)
 - **Flag設定**： 為了達到漸亮、漸暗的切換，設定 B ( Counter2)大一個 bit 的 q 作為旗標。
![image](https://user-images.githubusercontent.com/61071600/173220857-ec2c2a6d-2790-48e2-ad5a-22e982c9140e.png)
## 制定參數
 - **Counter1 頻率**：一般人眼的刷新率極限約為 200Hz，為避免感知到明顯閃爍，使燈的明亮變化連續，LED 的閃爍頻率需大於 200Hz，該頻率即為 Counter1 頻率，Counter1 的頻率由 MSB 而定。

```50 × (10^6) ÷ (2^𝑛) ≥ 200 → n ≤ 17.9```

由此得知 Counter1 的 MSB 不能超過 17。
 - **Counter2 頻率**：該頻率決定呼吸燈循環一個週期的時間，同樣由 Counter2 的 MSB 所定。
![image](https://user-images.githubusercontent.com/61071600/173220957-784b4477-5261-4516-9233-1bb4f2fcf5a7.png)
 - **解析度**：目標解析度有 256 個明暗色階，因此 Counter1、Counter2 的 A、B 選擇 8 個 bits。

## 結果
![image](https://user-images.githubusercontent.com/61071600/173220993-454a9ebf-755d-4180-b791-7453205d2ea1.png)
![image](https://user-images.githubusercontent.com/61071600/173221000-2c20c4d6-9910-4202-bd33-4843246acb84.png)
