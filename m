Return-Path: <anders.tornqvist@codiax.se>
X-Greylist: delayed 963 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 14 May 2019 08:24:29 UTC
Received: from mailrelay3-2.pub.mailoutpod1-cph3.one.com
	(mailrelay3-2.pub.mailoutpod1-cph3.one.com [46.30.212.2])
	by mail.openembedded.org (Postfix) with ESMTP id 7B9357DF0B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 May 2019 08:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codiax.se; s=20140924;
	h=content-type:subject:reply-to:from:to:message-id:mime-version:date:from;
	bh=Np62UtsB+JkV9Hf6NrV6QNpXZUIy44BZuqi722TYV8Y=;
	b=Ycz895fUJU0wrQOL0vEU8xvqgfOSErbDRd71wWipVDrhGZ+RrTSeAPiLtqbbvL2h7GFY22RK4Nu4c
	VcRFEB4SXgJL8Nwsx7y/mghlUGGmzpjTydG5JoTK8CRwZnwJCmz6ycJgsYzj4+A7nnWtAaBxpaD+zv
	KzZiBQ5eHNHfKLBs=
X-HalOne-Cookie: 0b46808e887da29914b520eebd91488e7419efcc
X-HalOne-ID: 736393df-761f-11e9-a0de-d0431ea8bb03
Received: from onecom-webmail2 (unknown [46.30.211.130])
	by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
	id 736393df-761f-11e9-a0de-d0431ea8bb03;
	Tue, 14 May 2019 08:08:26 +0000 (UTC)
X-Originating-IP: 212.209.3.5
User-Agent: One.com webmail 33.0.23
Date: Tue, 14 May 2019 10:08:26 +0200
MIME-Version: 1.0
Message-ID: <1557821306096.66661.654@webmail5>
To: <bitbake-devel@lists.openembedded.org>
From: <anders.tornqvist@codiax.se>
Reply-To: <anders.tornqvist@codiax.se>
X-Mailman-Approved-At: Tue, 14 May 2019 22:15:53 +0000
Subject: Bitbake hangs when there is no response from remote PR server
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 14 May 2019 08:24:29 -0000
Content-Type: multipart/alternative; boundary="----------652-1557821306096-1"

------------652-1557821306096-1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

When using Bitbake from Poky Sumo I noticed that bitbake hangs forever if t=
here is PRSERV_HOST configured to a another host and that does not answer t=
o the requests.
It does not timeout and gives no error message.

A possible solution could be to change the handling the limit of the retrie=
s in lib/bb/main.py setup_bitbake().
Currently the time-out for a not responding PRSERV_HOST does not seem to co=
unt down the retries. It just keeps on retrying.

/Anders


------------652-1557821306096-1
Content-Type: multipart/related; boundary="----------652-1557821306096-2"

------------652-1557821306096-2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<div>Hi,<br></div><div><br></div><div>When using Bitbake from Poky Sumo I n=
oticed that bitbake hangs forever if there is PRSERV_HOST configured to a a=
nother host and that does not answer to the requests.<br></div><div>It does=
 not timeout and gives no error message.<br></div><div><br></div><div>A pos=
sible solution could be to change the handling the limit of the retries in =
lib/bb/main.py setup_bitbake().<br></div><div>Currently the time-out for a =
not responding PRSERV_HOST does not seem to count down the retries. It just=
 keeps on retrying.<br></div><div><br></div><div>/Anders<br></div>

------------652-1557821306096-2--

------------652-1557821306096-1--
