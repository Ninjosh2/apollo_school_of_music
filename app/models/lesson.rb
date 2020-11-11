class Lesson < ApplicationRecord
  belongs_to :teacher
  belongs_to :student

  validates :start_time, :end_time, :location, presence: true
  validate :teacher_dbl_booked, :student_dbl_booked, :ends_after_it_starts


  def teacher_dbl_booked
    this_start = self.start_time
    this_end = self.end_time
    conflict = teacher.lessons.any? do |lesson|
      other_start = lesson.start_time
      other_end = lesson.end_time
      other_start < this_end && this_end < other_end || other_start < this_start && this_start < other_end
    end
    if conflict
      errors.add(:teacher, 'Is already booked!')
    end
  end

  def student_dbl_booked
    this_start = self.start_time
    this_end = self.end_time
    conflict = student.lessons.any? do |lesson|
      other_start = lesson.start_time
      other_end = lesson.end_time
      other_start < this_end && this_end < other_end || other_start < this_start && this_start < other_end
    end
    if conflict
      errors.add(:student, 'Is already booked!')
    end
  end

  def ends_after_it_starts
    if start_time > end_time
      errors.add(:start_time, 'must be before end time')
    end
  end
end
