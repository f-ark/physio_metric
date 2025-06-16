# Physio Metric

## Amaç
Physio Metric, Flutter ile geliştirilen ve kullanıcının postürünü (duruşunu) analiz etmeye yarayan bir mobil uygulamadır. Uygulama, kullanıcının fotoğrafını veya kamera akışını kullanarak vücut eklem noktalarını otomatik olarak tespit eder, çeşitli postür bozukluklarını (ör. boyun düzleşmesi, baş önde duruş) analiz eder ve kullanıcıya kişiselleştirilmiş geri bildirim sunar.

## Temel Özellikler
- **Otomatik Fotoğraf Çekimi & Analiz:** Kullanıcı doğru pozisyona geldiğinde otomatik olarak fotoğraf çekilir ve analiz başlatılır.
- **ML Kit ile Eklem Noktası Tespiti:** Google ML Kit Pose Detection ile vücut eklem noktaları tespit edilir.
- **Postür Bozukluğu Analizi:** Boyun düzleşmesi, baş önde duruş gibi bozukluklar tespit edilir.
- **Strateji Pattern ile Esnek Tanı:** Her tanı algoritması ayrı bir strateji olarak uygulanır, kolayca yeni tanı eklenebilir.
- **Riverpod ile Durum Yönetimi ve DI:** Tüm bağımlılıklar ve servisler Riverpod ile yönetilir.
- **Katmanlı Mimari:** Kod okunabilirliği, test edilebilirlik ve sürdürülebilirlik için katmanlı mimari kullanılır.

## Mimari
Uygulama, modern Flutter projelerinde önerilen **katmanlı mimari** ile geliştirilmiştir:

```
lib/features/posture/
  data/         # Dış veri kaynakları, repository'ler (ML Kit, kamera, dosya)
  application/  # İş akışı ve servisler (fotoğraf çek, analiz başlat, stream yönetimi)
  domain/       # İş kuralları, analiz algoritmaları, tanı stratejileri, modeller
  presentation/ # UI, controller, widget'lar
```

### Domain Katmanı
- **Value Object:** `PostureDeviation` analiz sonuçlarını taşır ve Equatable ile karşılaştırılır.
- **Analyzer:** `PostureAnalyzer` eklem noktalarından açı ve sapma hesaplar.


### Application Katmanı
- **PostureCaptureService:** Kamera stream'inden gelen karelerde ideal poz yakalanana kadar dinler, uygun karede analiz başlatır.

### Data Katmanı
- **PhotoRepository:** Fotoğraf çekme ve galeri işlemleri.
- **PoseRepository:** ML Kit ile eklem noktası tespiti.

### Presentation Katmanı
- **UI:** Kullanıcıdan fotoğraf alır, analiz sonuçlarını ve tanı raporunu gösterir.

## Kullanılan Teknolojiler
- **Flutter** (mobil uygulama geliştirme)
- **Riverpod 3.x** (durum yönetimi ve dependency injection)
- **google_mlkit_pose_detection** (eklem noktası tespiti)
- **image_picker** (fotoğraf çekme/galeri)
- **equatable** (value object karşılaştırma)

## Temel Kullanım Akışı
1. Kullanıcıdan kamera veya galeri ile fotoğraf alınır.
2. ML Kit ile eklem noktaları tespit edilir.
3. PostureAnalyzer ile açı ve sapmalar hesaplanır.
4. Strateji pattern ile çeşitli postür bozuklukları analiz edilir.
5. Sonuçlar kullanıcıya görsel ve metin olarak sunulur.

## Katkı ve Geliştirme
- Katmanlı mimari ve design pattern'ler ile kodun sürdürülebilirliği ön plandadır.
- Yeni bir postür tanısı eklemek için sadece yeni bir strateji fonksiyonu yazıp provider'a eklemeniz yeterlidir.

## Lisans
MIT
