require('spec_helper')

describe(Division) do
  describe('#department') do
    it('returns the department of the division') do
      test_division = Division.new({:department => 'HR'})
      expect(test_division.department()).to(eq('HR'))
    end
  end

  describe("#employees") do
    it("assign employees to division") do
      test_division = Division.create({:department => 'HR'})
      test_employee = Employee.create({:name => "Jim Beam", :division_id => test_division.id()})
      expect(test_division.employees()).to(eq([test_employee]))
    end
  end

  describe('.find') do
    it('returns division based on its id numner') do
      test_division = Division.create({:department => 'HR'})
      expect(Division.find(test_division.id())).to(eq(test_division))
    end
  end
end
