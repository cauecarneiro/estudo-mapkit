# Estudo de MapKit

Estudo do MapKit em SwiftUI: anotação personalizada, Look Around, localização do usuário e controles do mapa.

Estudo · iOS 26 · 2025

## O que faz
- Abre o mapa no Apple Visitor Center, em Cupertino, com visão 3D realista.
- Mostra uma anotação personalizada (ícone e cor própria) com um menu de contexto.
- Abre o Look Around do local a partir do menu de contexto.
- Mostra a localização do usuário e os controles do mapa: botão de localização, bússola, inclinação e escala.

## Meu papel
Estudo solo. Todos os commits são meus.

## Como foi feito
- Tudo em `ContentView.swift`, com a API de `Map` do iOS 17 em diante (`MapCameraPosition`, `Annotation`, `UserAnnotation`, `MapPolyline`).
- `MKLookAroundSceneRequest` busca a cena do Look Around; `CLLocationUpdate.liveUpdates()` lê a localização.
- O código já prevê uma rota (`MKRoute` desenhada com `MapPolyline`), mas o botão "Get Diretions" do menu ainda não calcula nada.

## Tecnologias
Swift, SwiftUI, MapKit e CoreLocation.

## Como rodar
1. Abra `MapKitApp/MapKitApp.xcodeproj` no Xcode.
2. Rode num simulador com iOS 26 ou mais novo (o Look Around precisa de cobertura do local e de internet).

---
Feito por Cauê Crillanovick · [portfólio](https://cauecarneiro.github.io/portfolio/) · [LinkedIn](https://www.linkedin.com/in/cau%C3%AA-carneiro)
