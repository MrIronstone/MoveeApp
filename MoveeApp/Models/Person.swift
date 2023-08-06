//
//  Person.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 5.08.2023.
//

struct Person: Codable, Identifiable, Hashable {
    let id: Int
    let creditId: String?
    let imdbId: String?
    let name: String?
    let originalName: String?
    let profilePath: String?
    let biography: String?
    let placeOfBirth: String?
    let birtday: String?
    let deathday: String?
    let knownForDepartment: String?
    let popularity: Double?
    let castId: Int?
    let character: String?
    let order: Int?
    let department: String?
    let job: String?
    
    
    static func example1() -> Person {
        let person = Person(
            id: 22970,
            creditId: nil,
            imdbId: "nm227759",
            name: "Peter Dinklage",
            originalName: nil,
            profilePath: "/wSyk4uT4hjWM93X8ThMRx57R6mm.jpg",
            // swiftlint:disable line_length
            biography: "Peter Dinklage is an American actor. Since his breakout role in The Station Agent (2003), he has appeared in numerous films and theatre plays. Since 2011, Dinklage has portrayed Tyrion Lannister in the HBO series Game of Thrones. For this he won an Emmy for Outstanding Supporting Actor in a Drama Series and a Golden Globe Award for Best Supporting Actor - Series, Miniseries or Television Film in 2011. Peter Hayden Dinklage was born in Morristown, New Jersey, to Diane (Hayden), an elementary school teacher, and John Carl Dinklage, an insurance salesman. He is of German, Irish, and English descent. In 1991, he received a degree in drama from Bennington College and began his career. His exquisite theatre work that expresses brilliantly the unique range of his acting qualities, includes remarkable performances full of profoundness, charisma, intelligence, sensation and insights in plays such as \"The Killing Act\", \"Imperfect Love\", Ivan Turgenev's \"A Month in the Country\" as well as the title roles in William Shakespeare's \"Richard III\" and in Anton Chekhov's \"Uncle Vanya\". Peter Dinklage received acclaim for his first film, Living in Oblivion (1995), where he played an actor frustrated with the limited and caricatured roles offered to actors who have dwarfism. In 2003, he starred in The Station Agent (2003), written and directed by Tom McCarthy. The movie received critical praise as well as Peter Dinklage's work including nominations such as for Outstanding Performance by a Male Actor in a Leading Role at the \"Screen Actors Guild\" and Best Male Lead at the \"Film Independent Spirit Awards\". One of his next roles has been the one of Miles Finch, an acclaimed children's book author, in Elf (2003). Sob Suspeita (2006), the original English Death at a Funeral (2007), its American remake Death at a Funeral (2010), Penelope (2006), The Chronicles of Narnia: Prince Caspian (2008) and X-Men: Days of Future Past (2014) are also included in his brilliant work concerning feature films. His fine work in television also includes shows such as Entourage (2004), Life as We Know It (2004), Threshold (2005) and Nip/Tuck (2003). In 2011, the primary role of Tyrion Lannister, a man of sharp wit and bright spirit, in Game of Thrones (2011), was incarnated with unique greatness in Dinklage's unparalleled performance. The series is an adaptation of author George R.R. Martin's A Song of Ice and Fire series, and his work has received widespread praise, highlighted by his receiving the Emmy Award for Outstanding Supporting Actor in a Drama Series at The 63rd Primetime Emmy Awards (2011), The 67th Primetime Emmy Awards (2015) and The 70th Primetime Emmy Awards (2018), as well as The 69th Annual Golden Globe Awards (2012) for Best Supporting Actor - Series, Miniseries or Television Film. In 2012, Dinklage voiced Captain Gutt in Ice Age: Continental Drift (2012). In 2014, he starred in the comedy horror film Knights of Badassdom (2013) and portrayed Bolivar Trask in the superhero film X-Men: Days of Future Past (2014). In 2016, Dinklage provided the voice of The Mighty Eagle in The Angry Birds Movie (2016).",
            // swiftlint:enable line_length
            placeOfBirth: "Morristown, New Jersey, USA",
            birtday: "1969-06-11",
            deathday: nil,
            knownForDepartment: "Acting",
            popularity: 26.691,
            castId: nil,
            character: nil,
            order: nil,
            department: nil,
            job: nil
        )
        return person
    }
}
