import { useState } from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";

const scenarios = [
  {
    id: "feelings",
    title: "I want to talk about how I'm feeling",
    questions: [
      "How are you feeling today?",
      "What has been on your mind lately?",
      "Is there anything making you feel upset or happy?"
    ]
  },
  {
    id: "school",
    title: "I have a problem at school",
    questions: [
      "What problem are you having at school?",
      "Who is involved?",
      "How does it make you feel?"
    ]
  }
];

export default function SpeakUpApp() {
  const [step, setStep] = useState("choose");
  const [selectedScenario, setSelectedScenario] = useState(null);
  const [answers, setAnswers] = useState([]);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [currentAnswer, setCurrentAnswer] = useState("");

  const handleScenarioSelect = (scenario) => {
    setSelectedScenario(scenario);
    setStep("questions");
    setAnswers([]);
    setCurrentQuestionIndex(0);
    setCurrentAnswer("");
  };

  const handleNext = () => {
    const updatedAnswers = [...answers, currentAnswer];
    setAnswers(updatedAnswers);
    setCurrentAnswer("");
    if (currentQuestionIndex + 1 < selectedScenario.questions.length) {
      setCurrentQuestionIndex(currentQuestionIndex + 1);
    } else {
      setStep("summary");
    }
  };

  const renderScenarioSelection = () => (
    <div className="grid gap-4">
      {scenarios.map((s) => (
        <Card key={s.id} onClick={() => handleScenarioSelect(s)} className="cursor-pointer">
          <CardContent className="p-4">{s.title}</CardContent>
        </Card>
      ))}
    </div>
  );

  const renderQuestion = () => (
    <div className="space-y-4">
      <p className="text-lg font-medium">
        {selectedScenario.questions[currentQuestionIndex]}
      </p>
      <Input
        value={currentAnswer}
        onChange={(e) => setCurrentAnswer(e.target.value)}
        placeholder="Type your answer..."
      />
      <Button onClick={handleNext} disabled={!currentAnswer.trim()}>
        {currentQuestionIndex + 1 === selectedScenario.questions.length ? "Finish" : "Next"}
      </Button>
    </div>
  );

  const renderSummary = () => (
    <div className="space-y-4">
      <h2 className="text-xl font-bold">Your Report</h2>
      {selectedScenario.questions.map((q, i) => (
        <div key={i}>
          <p className="font-medium">{q}</p>
          <p className="text-gray-700">{answers[i]}</p>
        </div>
      ))}
      <Button onClick={() => setStep("choose")}>Start Over</Button>
    </div>
  );

  return (
    <div className="max-w-xl mx-auto p-6">
      <h1 className="text-2xl font-bold mb-6">SpeakUp</h1>
      {step === "choose" && renderScenarioSelection()}
      {step === "questions" && renderQuestion()}
      {step === "summary" && renderSummary()}
    </div>
  );
}
