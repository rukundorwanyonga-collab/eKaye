#include <iostream>
#include <string>

int main() {
    std::string izina;
    double nota1, nota2, nota3;
    double impuzandengo;

    std::cout << "=== IKAYE Y'AMANOTA Y'ABANYESHURI ===" << std::endl;
    
    std::cout << "Andika izina ry'umunyeshuri: ";
    std::cin >> izina;
    
    std::cout << "Andika inota rya mbere (mu ijana): ";
    std::cin >> nota1;
    
    std::cout << "Andika inota rya kabiri: ";
    std::cin >> nota2;
    
    std::cout << "Andika inota rya gatatu: ";
    std::cin >> nota3;
    
    // Kubara average
    impuzandengo = (nota1 + nota2 + nota3) / 3;
    
    std::cout << "\n--- UMUSARURO ---" << std::endl;
    std::cout << "Umunyeshuri: " << izina << std::endl;
    std::cout << "Impuzandengo y'amanota ye ni: " << impuzandengo << "%" << std::endl;
    
    // Kureba niba yatsinze (Koresha If/Else)
    if (impuzandengo >= 50) {
        std::cout << "IKYEMEZO: YATSINZE! " << std::endl;
    } else {
        std::cout << "IKYEMEZO: YASUBIYE NYUMA! " << std::endl;
    }
    
    return 0;
}
