classdef testCompactCSR < matlab.unittest.TestCase
    properties
    end
    
    methods (Test)        
        function testElemCompactCSR(testCase)
            s = 0.2;
            for n = 10:10:50
                M = makeSparse(n, s);
                C = toCompactCSR(M);
                for i = 1:n
                    for j = 1:n
                        testCase.assertEqual(M(i,j), elemCompactCSR(C,i,j));
                    end
                end
            end
        end
        
        function testExtractRowCompactCSR(testCase)
            s = 0.2;
            for n = 10:10:50
                M = makeSparse(n, s);
                C = toCompactCSR(M);
                for i = 1:n
                    testCase.assertEqual(M(i,:), extractRowCompactCSR(C,i));
                end
            end
        end
                
        function testExtractColCompactCSR(testCase)
            s = 0.2;
            for n = 10:10:50
                M = makeSparse(n, s);
                C = toCompactCSR(M);
                for j = 1:n
                    testCase.assertEqual(M(:,j), extractColCompactCSR(C,j));
                end
            end
        end
        
        function testToFullCompactCSR(testCase)
            s = 0.2;
            for n = 10:10:50
                M = makeSparse(n, s);
                C = toCompactCSR(M);
                M_convert = toFullCompactCSR(C);
                testCase.assertEqual(M, M_convert);
            end
        end
        
        function testProdCompactCSR(testCase)
            s = 0.2;
            for n = 10:10:50
                A = makeSparse(n, s);
                B = makeSparse(n, s);
                C = A * B;
                A_comp = toCompactCSR(A);
                B_comp = toCompactCSR(B);
                C_comp = prodCompactCSR(A_comp, B_comp);
                C_convert = toFullCompactCSR(C_comp);
                testCase.assertEqual(C, C_convert);
            end
        end
    end
end

