RSpec.describe TimeUtil do
  describe ".humanize" do
    it "converts a given duration in seconds into a human readable representation" do
      duration_4d_2h_3m_30s = (4 * TimeUtil::SECS_IN_DAY) + (2 * TimeUtil::SECS_IN_HOUR) + (3 * TimeUtil::SECS_IN_MIN) + 30
      human_4d_2h_3m_30s = "4 days, 2 hours, 3 mins, 30 seconds"
      expect(described_class.humanize(duration_4d_2h_3m_30s)).to eq(human_4d_2h_3m_30s)

      str_duration_4d_2h_3m_30s = duration_4d_2h_3m_30s.to_s
      expect(described_class.humanize(str_duration_4d_2h_3m_30s)).to eq(human_4d_2h_3m_30s)

      duration_4d_0h_3m_30s = (4 * TimeUtil::SECS_IN_DAY) + (3 * TimeUtil::SECS_IN_MIN) + 30
      human_4d_0h_3m_30s = "4 days, 3 mins, 30 seconds"
      expect(described_class.humanize(duration_4d_0h_3m_30s)).to eq(human_4d_0h_3m_30s)

      duration_0d_2h_3m_30s = (2 * TimeUtil::SECS_IN_HOUR) + (3 * TimeUtil::SECS_IN_MIN) + 30
      human_0d_2h_3m_30s = "2 hours, 3 mins, 30 seconds"
      expect(described_class.humanize(duration_0d_2h_3m_30s)).to eq(human_0d_2h_3m_30s)

      duration_1d_0h_0m_0s = TimeUtil::SECS_IN_DAY
      human_1d_0h_0m_0s = "1 days"
      expect(described_class.humanize(duration_1d_0h_0m_0s)).to eq(human_1d_0h_0m_0s)
    end

    it "raises ArgumentError if given a zero duration" do
      zero_duration = 0
      expect { described_class.humanize(zero_duration) }.to raise_error(ArgumentError)
    end

    it "raises ArgumentError if given a negative duration" do
      negative_duration = -1
      expect { described_class.humanize(negative_duration) }.to raise_error(ArgumentError)
    end

    it "raises ArgumentError if given a duration which cannot be converted into a number" do
      non_numeric_duration = "hello"
      expect { described_class.humanize(non_numeric_duration) }.to raise_error(ArgumentError)
    end
  end
end
