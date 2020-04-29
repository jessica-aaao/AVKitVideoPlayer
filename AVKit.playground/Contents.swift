//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport
//Adicione a linha abaixo acima da declaração da Classe
import AVKit

class MyViewController : UIViewController {
    //Criando o player que aparecerá na sua view
    var playerLayer: AVPlayerLayer!
    var player: AVPlayer!
    
    //Criando o array de vídeos
    var videos: [AVPlayerItem] = []
    
    //Variável que guardará o vídeo sendo reproduzido atualmente
    var currentVideo: Int!
    
    override func loadView() {
        //Criar e personalizar a View logo após a declaração da loadView()
        let view = UIView()
        view.backgroundColor = .white
        
        //Primeiro procuramos o local onde o vídeo está localizado
        //Em "forResource" coloque o nome do vídeo e em ofType sua extensão
        let NaturePath = Bundle.main.path(forResource: "Nature", ofType: "mp4")
        //Após localizá-lo, vamos transformar o caminho do arquivo em um URL que o código seja capaz de ler e buscar o vídeo
        let NatureURL = URL.init(fileURLWithPath: NaturePath!)
        //Depois de adicionado ao código, transformaremos o vídeo em um AVPlayerItem para que seja reconhecido pelo player
        let video_1 = AVPlayerItem(url: NatureURL as URL)
        //E aí sim adicionaremos o vídeo ao nosso array
        videos.append(video_1)
        
        //Repita os passos acima para todos os vídeos da sua playlist
        let HeartPath = Bundle.main.path(forResource: "Heart", ofType: "mp4")
        let HeartURL = URL.init(fileURLWithPath: HeartPath!)
        let video_2 = AVPlayerItem(url: HeartURL as URL)
        videos.append(video_2)
        
        let SlowMotionPath = Bundle.main.path(forResource: "SlowMotion", ofType: "mp4")
        let SlowMotionURL = URL.init(fileURLWithPath: SlowMotionPath!)
        let video_3 = AVPlayerItem(url: SlowMotionURL as URL)
        videos.append(video_3)
        
        let WaterPath = Bundle.main.path(forResource: "Water", ofType: "mp4")
        let WaterURL = URL.init(fileURLWithPath: WaterPath!)
        let video_4 = AVPlayerItem(url: WaterURL as URL)
        videos.append(video_4)
        
        let WaterfallPath = Bundle.main.path(forResource: "Waterfall", ofType: "mp4")
        let WaterfallURL = URL.init(fileURLWithPath: WaterfallPath!)
        let video_5 = AVPlayerItem(url: WaterfallURL as URL)
        videos.append(video_5)
        
        //Adicione o primeiro vídeo da sua playlist ao AVPlayer que você criou
        //Ou seja, o vídeo com índice 0 do seu array(ou qualquer outro índice por onde você deseje iniciar)
        player = AVPlayer(playerItem: videos[0])
        //Guarde o índice do primeiro vídeo
        currentVideo = 0
        
        //Agora crie o visual do seu player
        //1 - Adicione o AVPlayer ao AVPlayerLayer
        playerLayer = AVPlayerLayer(player: player)
        //2 - Configure o tamanho do seu player
        playerLayer.frame = CGRect(x: 0, y: 0, width: 378, height: 480)
        //3 - Indique o que acontecerá com o aspecto do vídeo para se adaptar ao player:
          //.resize ou .resizeAspect ou .resizeAspectFill
        playerLayer.videoGravity = .resizeAspectFill
        //Aqui você decide se o vídeo já iniciará automaticamente ou se esperará o usuário dar play
        player.pause()
        
        //Criar e personalizar os botões de Play, Pause, Stop, Próximo Vídeo e Vídeo Anterior
        let playButton = UIButton()
        playButton.setTitle("Play", for: .normal)
        playButton.backgroundColor = .clear
        playButton.setTitleColor(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), for: .normal)
        playButton.frame = CGRect(x: 165, y: 500, width: 50, height: 10)
        playButton.addTarget(nil, action: #selector(videoPlayer(sender:)), for: .touchUpInside)
        
        let pauseButton = UIButton()
        pauseButton.setTitle("Pause", for: .normal)
        pauseButton.backgroundColor = .clear
        pauseButton.setTitleColor(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), for: .normal)
        pauseButton.frame = CGRect(x: 85, y: 500, width: 50, height: 10)
        pauseButton.addTarget(nil, action: #selector(videoPlayer(sender:)), for: .touchUpInside)
        
        let stopButton = UIButton()
        stopButton.setTitle("Stop", for: .normal)
        stopButton.backgroundColor = .clear
        stopButton.setTitleColor(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), for: .normal)
        stopButton.frame = CGRect(x: 245, y: 500, width: 50, height: 10)
        stopButton.addTarget(nil, action: #selector(videoPlayer(sender:)), for: .touchUpInside)
        
        let nextButton = UIButton()
        nextButton.setTitle("Next", for: .normal)
        nextButton.backgroundColor = .clear
        nextButton.setTitleColor(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), for: .normal)
        nextButton.frame = CGRect(x: 320, y: 500, width: 50, height: 10)
        nextButton.addTarget(nil, action: #selector(videoPlayer(sender:)), for: .touchUpInside)
        
        let previousButton = UIButton()
        previousButton.setTitle("Prev", for: .normal)
        previousButton.setTitleColor(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), for: .normal)
        previousButton.backgroundColor = .clear
        previousButton.frame = CGRect(x: 5, y: 500, width: 50, height: 10)
        previousButton.addTarget(nil, action: #selector(videoPlayer(sender:)), for: .touchUpInside)
        
        
        view.addSubview(playButton)
        view.addSubview(pauseButton)
        view.addSubview(stopButton)
        view.addSubview(nextButton)
        view.addSubview(previousButton)
        view.layer.addSublayer(playerLayer)
        self.view = view
    }
    
    @IBAction func videoPlayer(sender: UIButton){
        //Checando qual botão foi pressionado (sender = botão que "chamou" a função
        let touchedButton = sender.titleLabel!.text
        
        //Ação do botão "Play"
        if touchedButton == "Play" {
            //Garante que o vídeo estará no tempo 0
            player.currentItem?.seek(to: CMTime.zero, completionHandler: nil)
            
            //Dá play no vídeo
            player.play()
        
        //Ação do botão "Pause"
        } else if touchedButton == "Pause" {
            //pausa o vídeo
            player.pause()
        
        //Ação do botão "Stop"
        } else if touchedButton == "Stop"{
            //Seta o tempo do vídeo para o final
            player.currentItem?.seek(to: player.currentItem!.duration, completionHandler: nil)
            //Pausa o vídeo
            player.pause()
            
        //Ação do botão "Próximo Vídeo"
        } else if touchedButton == "Next"{
            //Checa se o vídeo atual é o último da lista
            if currentVideo < (videos.count - 1){
                //Se não for acrescenta um ao índice do vídeo atual
                currentVideo = currentVideo + 1
                
            } else {
                //Se for, volta ao início da playlist
                currentVideo = 0
            }
            
            //Substitui o vídeo sendo reproduzido pelo próximo vídeo do array
            player.replaceCurrentItem(with: videos[currentVideo])
            //Dá play no próximo vídeo
            player.play()
        
        //ação do botão "Vídeo Anterior"
        } else if touchedButton == "Prev"{
            //Checa se o vídeo é o primeiro da playlist
            if currentVideo > 0 {
                //Se não for, diminui um do índice do vídeo atual
                currentVideo = currentVideo - 1
                
            } else {
                //Se for, coloca o índice do último vídeo da lista
                currentVideo = videos.count - 1
            }
            
            //Substitui o vídeo sendo reproduzido pelo vídeo anterior do array
            player.replaceCurrentItem(with: videos[currentVideo])
            //Dá play no vídeo anterior
            player.play()
        }
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
