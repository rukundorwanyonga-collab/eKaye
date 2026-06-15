#include <iostream>
#include <string>
#include <vector>

using namespace std;

// ==========================================================
// 1. STRUCTURES (IMITERERE Y'AMAKURU YOSE)
// ==========================================================

struct Abanyamuryango {
    string ID;
    string izina;
    string indangamuntu;
    double umugabane;
    double amande;
    double ingoboka;
    string itariki_yiyandikishije;

    Abanyamuryango(string t, string i, string y, double b, double f, double r, string g)
        : ID(t), izina(i), indangamuntu(y), umugabane(b), amande(f), ingoboka(r), itariki_yiyandikishije(g) {}
};

struct Inguzanyo {
    string ID;
    string member_ID; 
    double ingano_yinguzanyo; 
    double inyungu;           
    long long itariki_ntarengwa; 
    bool yarishyuye;

    Inguzanyo(string id, string m_id, long long itariki)
        : ID(id), member_ID(m_id), ingano_yinguzanyo(0.0), inyungu(0.0), itariki_ntarengwa(itariki), yarishyuye(false) {}
};

struct ComiteNyobozi {
    string coop_ID;
    string perezida_id; string perezida_telefone; string perezida_password; bool perezida_yarinjiye;
    string umwanditsi_id; string umwanditsi_telefone; string umwanditsi_password; bool umwanditsi_yarinjiye;
    string umubitsi_id; string umubitsi_telefone; string umubitsi_password; bool umubitsi_yarinjiye;
    long long manda_itangira;
    long long manda_irangira;

    ComiteNyobozi(string c_id, string p_id, string p_tel, string p_pass,
                   string w_id, string w_tel, string w_pass,
                   string t_id, string t_tel, string t_pass,
                   long long m_itangira, long long m_irangira)
        : coop_ID(c_id), 
          perezida_id(p_id), perezida_telefone(p_tel), perezida_password(p_pass), perezida_yarinjiye(false),
          umwanditsi_id(w_id), umwanditsi_telefone(w_tel), umwanditsi_password(w_pass), umwanditsi_yarinjiye(false),
          umubitsi_id(t_id), umubitsi_telefone(t_tel), umubitsi_password(t_pass), umubitsi_yarinjiye(false),
          manda_itangira(m_itangira), manda_irangira(m_irangira) {}
};

struct IgikorwaMari {
    string trans_id;
    string member_id;
    string ubwoko;       
    double amafaranga;
    string itariki;
    string status;       
    string uwanditse_id; 

    IgikorwaMari(string t_id, string m_id, string ubw, double amf, string itr, string stat, string uw_id)
        : trans_id(t_id), member_id(m_id), ubwoko(ubw), amafaranga(amf), itariki(itr), status(stat), uwanditse_id(uw_id) {}
};

struct Ikigega {
    string coop_id;
    string izina_ryitsinda;
    double total_savings;    
    double total_loans_out;  
    double cash_in_hand;     

    Ikigega(string c_id, string izina, double savings, double loans, double cash)
        : coop_id(c_id), izina_ryitsinda(izina), total_savings(savings), total_loans_out(loans), cash_in_hand(cash) {}
};

// ==========================================================
// 2. FUNCTIONS (IMIKORERE N'AMATEGEKO Y'UMUTEKANO)
// ==========================================================

void kwinjizaUmunyamuryango(vector<Abanyamuryango>& urutonde, string id, string izina, string ndangamuntu, double umugabane, double amande, double ingoboka, string itariki) {
    if (ndangamuntu.length() != 16) {
        cout << "[IKOSA] Umunyamuryango " << izina << " ntiyanditswe! Indangamuntu igomba kuba imibare 16!\n";
        return;
    }
    for (const auto& umuryango : urutonde) {
        if (umuryango.indangamuntu == ndangamuntu || umuryango.ID == id) {
            cout << "[IKOSA] Umunyamuryango " << izina << " ntiyanditswe! Indangamuntu cyangwa ID isanzwemo!\n";
            return;
        }
    }
    Abanyamuryango umuryango_mushya(id, izina, ndangamuntu, umugabane, amande, ingoboka, itariki);
    urutonde.push_back(umuryango_mushya);
    cout << "[BYAKUNZE] Umunyamuryango " << izina << " yanditswe neza.\n";
}

void gukoraIgikorwaMari(vector<Abanyamuryango>& urutonde_abanyamuryango, Ikigega& ikigega_rusange, vector<IgikorwaMari>& amateka_ledg, 
                        string trans_id, string member_id, string ubwoko, double amafaranga, string itariki, ComiteNyobozi& komite) {
    
    if (komite.umwanditsi_yarinjiye == false) {
        cout << "[IKOSA RIKOMEYE] Igikorwa cyanze! Banza uha Umwanditsi uburenganzira bwo kwinjira!\n";
        return;
    }

    if (amafaranga <= 0) {
        cout << "[IKOSA] Ntushobora gukora igikorwa cy'amafaranga ari munsi ya 1 RWF!\n";
        return;
    }

    int index_muryango = -1;
    for (int i = 0; i < urutonde_abanyamuryango.size(); i++) {
        if (urutonde_abanyamuryango[i].ID == member_id) {
            index_muryango = i;
            break;
        }
    }

    if (index_muryango == -1) {
        cout << "[IKOSA] Igikorwa cyanze kuko member_id " << member_id << " ntabaho muri sisitemu!\n";
        return;
    }

    // Gukora igikorwa gishya kigatangira ari PENDING
    IgikorwaMari igikorwa_gishya(trans_id, member_id, ubwoko, amafaranga, itariki, "PENDING", komite.umwanditsi_id);
    cout << "[PENDING CHECK] Igikorwa " << trans_id << " cyanditswe, kiri kuri PENDING.\n";

    cout << "[REAL-TIME MONITORING] Perezida n'Umubitsi bameze APPROVE...\n";
    
    if (ubwoko == "KWONGERA_UMUGABANE") {
        urutonde_abanyamuryango[index_muryango].umugabane += amafaranga;
        ikigega_rusange.total_savings += amafaranga;
        ikigega_rusange.cash_in_hand += amafaranga;
        igikorwa_gishya.status = "APPROVED";
        cout << "[OK APPROVED] " << amafaranga << " RWF yongewe ku mugabane wa " << urutonde_abanyamuryango[index_muryango].izina << ".\n";
    } 
    else if (ubwoko == "GUFATA_INGUZANYO") {
        if (amafaranga > ikigega_rusange.cash_in_hand) {
            igikorwa_gishya.status = "REJECTED";
            cout << "[IKOSA REJECTED] Inguzanyo yanze: Cash in Hand ntihagije!\n";
        } else {
            ikigega_rusange.total_loans_out += amafaranga;
            ikigega_rusange.cash_in_hand -= amafaranga;
            igikorwa_gishya.status = "APPROVED";
            cout << "[OK APPROVED] Inguzanyo ya " << amafaranga << " RWF yasohotse mu kigega.\n";
        }
    }
    
    amateka_ledg.push_back(igikorwa_gishya);
}

void gucungaImiyoborere(ComiteNyobozi& komite, int amahitamo, string tel, string pin, long long itariki) {
    if (itariki > komite.manda_irangira) {
        cout << "[IKOSA] Manda yararangiye!\n";
        return;
    }
    
    // Switch Case icunga inshingano z'abayobozi hashingiye ku ma phone zabo
    switch (amahitamo) {
        case 1: // Perezida
            if (tel == komite.perezida_telefone && pin == komite.perezida_password) {
                komite.perezida_yarinjiye = true;
                cout << "[LOGIN OK] Perezida yarinjiye neza! (Read-Only & Approver)\n";
            } else {
                cout << "[IKOSA] Nomero cyangwa PIN ya Perezida ntiyizewe!\n";
            }
            break;
        case 2: // Umwanditsi
            if (tel == komite.umwanditsi_telefone && pin == komite.umwanditsi_password) {
                komite.umwanditsi_yarinjiye = true;
                cout << "[LOGIN OK] Umwanditsi yarinjiye neza! (Writer)\n";
            } else {
                cout << "[IKOSA] Nomero cyangwa PIN y'Umwanditsi ntiyizewe!\n";
            }
            break;
        case 3: // Umubitsi
            if (tel == komite.umubitsi_telefone && pin == komite.umubitsi_password) {
                komite.umubitsi_yarinjiye = true;
                cout << "[LOGIN OK] Umubitsi yarinjiye neza! (Treasurer)\n";
            } else {
                cout << "[IKOSA] Nomero cyangwa PIN y'Umubitsi ntiyizewe!\n";
            }
            break;
        default:
            cout << "[IKOSA] Hitamo inshingano ya 1, 2 cyangwa 3 gusa!\n";
            break;
    }
}

// ==========================================================
// 3. MAIN FUNCTION
// ==========================================================
int main() {
    vector<Abanyamuryango> abanyamuryango_bose;
    vector<IgikorwaMari> amateka_ledg;
    
    // Kurema ikigega gifite 100,000 RWF bwa mberere
    Ikigega ikigega1("COOP01", "Abaharaniramujyo", 100000.0, 0.0, 100000.0);

    // Kurema Komite Nyobozi
    ComiteNyobozi komite1("COOP01", 
                          "MEM001", "0781", "12",  // Perezida
                          "MEM002", "0782", "56",  // Umwanditsi
                          "MEM003", "0783", "90",  // Umubitsi
                          20260101, 20281231);

    // Kwinjiza umunyamuryango witwa Kagabo
    kwinjizaUmunyamuryango(abanyamuryango_bose, "MEM001", "Kagabo Jean", "1199080012345678", 50000, 0, 5000, "12/06/2026");

    cout << "\n--- STEP 1: Umwanditsi arinjira bwa mberere ---\n";
    gucungaImiyoborere(komite1, 2, "0782", "56", 20260612);

    cout << "\n--- STEP 2: Kagabo azanye 10,000 RWF y'Umugabane mushya ---\n";
    gukoraIgikorwaMari(abanyamuryango_bose, ikigega1, amateka_ledg, "TXN001", "MEM001", "KWONGERA_UMUGABANE", 10000.0, "12/06/2026", komite1);

    cout << "\n--- STEP 3: Kagabo afashe Inguzanyo ya 40,000 RWF (Cash in hand iragabanuka!) ---\n";
    gukoraIgikorwaMari(abanyamuryango_bose, ikigega1, amateka_ledg, "TXN002", "MEM001", "GUFATA_INGUZANYO", 40000.0, "12/06/2026", komite1);

    cout << "\n--- STEP 4: Kureba uko Isanduku y'Ikigega ihagaze ubu ---\n";
    cout << "=================== IKIGEGA RUSANGE ===================\n";
    cout << "Izina ry'Itsinda: " << ikigega1.izina_ryitsinda << "\n";
    cout << "-> Total Savings   : " << ikigega1.total_savings << " RWF\n";
    cout << "-> Total Loans Out : " << ikigega1.total_loans_out << " RWF\n";
    cout << "-> Cash In Hand    : " << ikigega1.cash_in_hand << " RWF\n";
    cout << "=======================================================\n";

    return 0;
}
