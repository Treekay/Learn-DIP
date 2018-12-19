% ��ȡͼƬ
sourceImg = imread('src/barb.png');
[m, n] = size(sourceImg);

% ���ı任
[N, M] = meshgrid(1:n, 1:m);
centreImg = double(sourceImg).*(-1).^(M + N);

% ����Ҷ�任
fourierImg = fft2(centreImg);

% Butterworth��ͨ�˲�������Ƶ���˲�
D0 = [10, 20, 40, 80];
ButterworthFilter = zeros(m, n);
G = zeros(m, n);
for i = 1 : length(D0)
    % ���ɰ�����˹�˲���
    G = fourierImg;
    ButterworthFilter = 1./(1 + (sqrt((M - m/2).^2 + (N - n/2).^2)./D0(i)).^2);
    % ������˹�˲�
    G = G .* ButterworthFilter;
    % ��DFT�任��ȡʵ��
    G = real(ifft2(G));
    % �����ı任
    G = G.* (-1).^(M + N);
    % figure;
    subplot(2, 2, i);
    imshow(G, []);title(sprintf('D0 = %d', D0(i)));
    % saveas(gcf, sprintf('./res/res1/Butterworth_D0=%d.jpg', D0(i)));
end
 saveas(gcf, './res/res1/ButterworthComparison.jpg');