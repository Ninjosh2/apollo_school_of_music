
user = User.first_or_create(email: "test@test.com", password: "thisisatest", name: "Tester")


s1 = user.students.find_or_create_by(name: "Jojo Manilli", phone_number: "(817)558-0123", instrument: "Bass Guitar")
s2 = user.students.find_or_create_by(name: "Glen Tennis", phone_number: "(817)558-1234", instrument: "Guitar")
s3 = user.students.find_or_create_by(name: "Will Grello", phone_number: "(214)558-1234", instrument: "Drums")

t1 = Teacher.find_or_create_by(name: "Scott Clam", phone_number: "(214)363-1234", email: "scottclam@channel5.com", instrument:"Piano")
t2 = Teacher.find_or_create_by(name: "Bread Harrity", phone_number: "(707)363-4321", email: "breadh@thebreadbasket.com", instrument:"Guitar")
t3 = Teacher.find_or_create_by(name: "Palmer Scott", phone_number: "(707)587-4991", email: "palmerscott@gmail.com", instrument:"Voice")

9.times do
    teacher = [t1, t2, t3].sample
    start = [1,2,3,4,5,6].sample.days.ago + [1,2,3,4,5,6,7,8].sample.hour
    teacher.lessons.find_or_create_by(
        student: [s1,s2,s3].sample,
        start_time: start,
        end_time: start + 2.hour,
        location: ["The Apollo School", "Home School - In Person", "Home School - Online"].sample
    )
end