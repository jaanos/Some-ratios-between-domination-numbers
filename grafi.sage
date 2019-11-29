
# coding: utf-8

# In[ ]:


import random
import json

def sosed(h, k=1):
    c =random.random()
    print c
    for i in range(k):
        g = Graph(h)
        while True:
            if c <=0.25:
                b = len(g.vertices())
                a = randrange(0,b)
                g.add_vertex(name = b)
                g.add_edge(a,b)
                h = g
                break
            elif c <= 0.5 and c > 0.25:
                a = g.complement().random_edge()
                g.add_edge(a)
                h = g
                break
            elif c > 0.75:
                a = g.random_edge()
                g.delete_edge(a)
                if g.is_connected():
                    h = g
                    break
                else:
                    g.add_edge(a)
                    continue
            else:
                a = g.random_vertex()
                g.delete_vertex(a)
                if g.is_connected():
                    h = g
                    break
                else:
                    g.add_vertex(a)
                    continue
    return h

def kriterij_a(g, i):
    h = Graph(g)
    return (h.cartesian_product(graphs.CompleteGraph(i))).dominating_set(value_only = True, total = True)/RR((h.cartesian_product(graphs.CompleteGraph(i))).dominating_set(value_only = True))

def kriterij_b(g,i):
    h = Graph(g)
    return (h.cartesian_product(graphs.CompleteGraph(i))).dominating_set(value_only = True, total = True)/RR(h.dominating_set(value_only=True, total = True))

def sim_ann_a(n, p, k, ponovitve, i=1):
    g = graphs.RandomGNP(n,p)
    for m in range(ponovitve):
        t = ponovitve/(m+1)
        sos = sosed(g, i)
        razlika = RR(kriterij_a(g,k)) - RR(kriterij_a(sos,k))
        if razlika > 0:
            g = sos
        elif exp((razlika * 100)/t) > random.random():
            g = sos
        print m
    return g.sparse6_string(), float(kriterij_a(g,i))

def sim_ann_b(n, p, k, ponovitve, i=1):
    g = graphs.RandomGNP(n,p)
    for i in range(ponovitve):
        t = ponovitve/(i+1)
        sos = sosed(g)
        razlika = RR(kriterij_b(sos,k)) - RR(kriterij_b(g,k))
        if razlika > 0:
            g = sos
        elif exp((razlika * 100)/t) > random.random():
            g = sos
        print i
    return g.sparse6_string(), float(kriterij_b(g,i))


def test_seznam(n, p, sez, ponovitve, i=1):
    podatki = []
    for k in sez:
        graf_a, stevilo_a = sim_ann_a(n,p, k, ponovitve)
        graf_b, stevilo_b = sim_ann_b(n,p, k, ponovitve)
        podatki.append([graf_a, stevilo_a, graf_b, stevlio_b])
    	return podatki


def zapisi(podatki, i):
    with open("rezultati{}.json".format(i), "w") as f:
        json.dump(podatki, f)


# In[ ]:


for i in range(3,20):
    sez = [i]
    podatki = test_seznam(15, 0.5, sez, 1000, 2)
    zapisi(podatki, i)
    


    
    
    

