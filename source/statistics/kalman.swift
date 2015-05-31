// Kalman Filter development underway
//
//  kalman.swift
//  swiftex1
//
//  Created by V Lall on 6/27/14.
//  Copyright (c) 2014 swiftintel. All rights reserved.
//

//Converted form python kalmanfilter, needs to be fixed.
//Make a dot product function
import Foundation

func kf_predict(X, P, A, Q, B, U)->(){
    X = dot(A, X) + dot(B, U)
    P = dot(A, dot(P, A.T)) + Q
    return(X,P)
}

func kf_update(X, P, Y, H, R)->(){
    IM = dot(H, X)
    IS = R + dot(H, dot(P, H.T))
    K = dot(P, dot(H.T, inv(IS)))
    X = X + dot(K, (Y-IM))
    P = P - dot(K, dot(IS, K.T))
    LH = gauss_pdf(Y, IM, IS)
    return (X,P,K,IM,IS,LH)
}

func gauss_pdf(X, M, S)->(){
    if M.shape()[1] == 1:
    DX = X - tile(M, X.shape()[1])
    E = 0.5 * sum(DX * (dot(inv(S), DX)), axis=0)
    E = E + 0.5 * M.shape()[0] * log(2 * pi) + 0.5 * log(det(S))
    P = exp(-E)
    elif X.shape()[1] == 1:
    DX = tile(X, M.shape()[1])- M
    E = 0.5 * sum(DX * (dot(inv(S), DX)), axis=0)
    E = E + 0.5 * M.shape()[0] * log(2 * pi) + 0.5 * log(det(S))
    P = exp(-E)
    else: DX = X-M
    E = 0.5 * dot(DX.T, dot(inv(S), DX))
    E = E + 0.5 * M.shape()[0] * log(2 * pi) + 0.5 * log(det(S))
    P = exp(-E)
    return (P[0],E[0])
}
