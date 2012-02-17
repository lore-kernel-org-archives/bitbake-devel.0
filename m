Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <caleb@signalessence.com>) id 1RyVQ4-0003aW-70
	for bitbake-devel@lists.openembedded.org;
	Fri, 17 Feb 2012 22:32:44 +0100
Received: by iaby12 with SMTP id y12so5268955iab.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Feb 2012 13:24:29 -0800 (PST)
Received-SPF: pass (google.com: domain of caleb@signalessence.com designates
	10.50.6.138 as permitted sender) client-ip=10.50.6.138; 
Authentication-Results: mr.google.com; spf=pass (google.com: domain of
	caleb@signalessence.com designates 10.50.6.138 as permitted
	sender) smtp.mail=caleb@signalessence.com
Received: from mr.google.com ([10.50.6.138])
	by 10.50.6.138 with SMTP id b10mr13806914iga.21.1329513869304 (num_hops
	= 1); Fri, 17 Feb 2012 13:24:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.50.6.138 with SMTP id b10mr10921964iga.21.1329513869221; Fri,
	17 Feb 2012 13:24:29 -0800 (PST)
Received: by 10.43.47.10 with HTTP; Fri, 17 Feb 2012 13:24:29 -0800 (PST)
In-Reply-To: <CALy7FZHSxCmTD+cTAuRASaQNuw7mqGu44oYkVybsdgTJ-H6r1g@mail.gmail.com>
References: <CALy7FZHSxCmTD+cTAuRASaQNuw7mqGu44oYkVybsdgTJ-H6r1g@mail.gmail.com>
Date: Fri, 17 Feb 2012 13:24:29 -0800
Message-ID: <CALy7FZE46mK5CakeRdq-jXgqeZQ8Uio6UWkUPMT5xEc1bDKvZw@mail.gmail.com>
From: Caleb Crome <caleb@signalessence.com>
To: bitbake-devel@lists.openembedded.org
X-Gm-Message-State: ALoCoQk19DuxWsUYA8kUCz6TGp4lJMZ2wZIfkhZ+NHXhZkKWsm2ZyDn4Xzm4D0OMDA2rJhaLrejx
Subject: Re: bitbake Parser hangs on single core cpus
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 17 Feb 2012 21:32:44 -0000
X-Groupsio-MsgNum: 963
Content-Type: multipart/mixed; boundary=e89a8f6465ade61e1804b92f91e9

--e89a8f6465ade61e1804b92f91e9
Content-Type: text/plain; charset=ISO-8859-1

Argh, for some reason git send-email just won't work for me.  I it up,
it asks to confirm, I say, 'y', then nothing.  it just hangs.

Anyway, here's the patch as an attachment.  Will that work for you?

--e89a8f6465ade61e1804b92f91e9
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-There-seems-to-be-a-bug-in-the-number-of-Parser-thre.patch"
Content-Disposition: attachment; 
	filename="0001-There-seems-to-be-a-bug-in-the-number-of-Parser-thre.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gyrq6zim0

RnJvbSAzMGZlY2EwYWIzZjU5NDFjODhlYzI4ZDUwMzk0MGUwYzZjMjEyYzZhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDYWxlYiBDcm9tZSA8Y2FsZWJAc2lnbmFsZXNzZW5jZS5jb20+
CkRhdGU6IEZyaSwgMTcgRmViIDIwMTIgMTI6MjE6NTkgLTA4MDAKU3ViamVjdDogW3ByZWZpeD1Q
QVRDSF0gVGhlcmUgc2VlbXMgdG8gYmUgYSBidWcgaW4gdGhlIG51bWJlciBvZiBQYXJzZXIKIHRo
cmVhZHMgY3JlYXRlZC4gIFRoZSBudW1iZXIgb2YgdGhyZWFkcyBpcwogc2VsZi5udW1fcHJvY2Vz
c2VzIC0gMSBkdWUgdG8gdGhlIHJhbmdlKDEsCiBzZWxmLm51bV9wcm9jZXNzZXMpLgoKVGhpcyBj
YXVzZXMgdGhlIFBhcnNlciB0byBoYW5nIGF0IDAlIG9uIHNpbmdsZSBjb3JlIG1hY2hpbmVzLgoK
VGhpcyBmaXhlcyB0aGUgUGFyc2VycyB0byB3b3JrIG9uIHNpbmdsZWNvcmUgbWFjaGluZXMuCi0t
LQogbGliL2JiL2Nvb2tlci5weSB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2xpYi9iYi9jb29rZXIucHkgYi9s
aWIvYmIvY29va2VyLnB5CmluZGV4IDgxODhhYWUuLjFhOWNhYjcgMTAwNjQ0Ci0tLSBhL2xpYi9i
Yi9jb29rZXIucHkKKysrIGIvbGliL2JiL2Nvb2tlci5weQpAQCAtMTUzNCw3ICsxNTM0LDcgQEAg
Y2xhc3MgQ29va2VyUGFyc2VyKG9iamVjdCk6CiAgICAgICAgICAgICBzZWxmLnJlc3VsdF9xdWV1
ZSA9IG11bHRpcHJvY2Vzc2luZy5RdWV1ZSgpCiAgICAgICAgICAgICBzZWxmLmZlZWRlciA9IEZl
ZWRlcihzZWxmLndpbGxwYXJzZSwgc2VsZi5qb2JzLCBzZWxmLmZlZWRlcl9xdWl0KQogICAgICAg
ICAgICAgc2VsZi5mZWVkZXIuc3RhcnQoKQotICAgICAgICAgICAgZm9yIGkgaW4gcmFuZ2UoMSwg
c2VsZi5udW1fcHJvY2Vzc2VzKToKKyAgICAgICAgICAgIGZvciBpIGluIHJhbmdlKDAsIHNlbGYu
bnVtX3Byb2Nlc3Nlcyk6CiAgICAgICAgICAgICAgICAgcGFyc2VyID0gUGFyc2VyKHNlbGYuam9i
cywgc2VsZi5yZXN1bHRfcXVldWUsIHNlbGYucGFyc2VyX3F1aXQsIGluaXQpCiAgICAgICAgICAg
ICAgICAgcGFyc2VyLnN0YXJ0KCkKICAgICAgICAgICAgICAgICBzZWxmLnByb2Nlc3Nlcy5hcHBl
bmQocGFyc2VyKQotLSAKMS43LjUuNAoK

--e89a8f6465ade61e1804b92f91e9--
