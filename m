Return-Path: <benixvincent@yahoo.com>
Received: from nm2-vm1.bullet.mail.bf1.yahoo.com
	(nm2-vm1.bullet.mail.bf1.yahoo.com [98.139.213.158])
	by mail.openembedded.org (Postfix) with ESMTP id CAC096066A
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Aug 2013 08:49:22 +0000 (UTC)
Received: from [98.139.212.151] by nm2.bullet.mail.bf1.yahoo.com with NNFMP;
	02 Aug 2013 08:49:22 -0000
Received: from [98.139.212.218] by tm8.bullet.mail.bf1.yahoo.com with NNFMP;
	02 Aug 2013 08:49:22 -0000
Received: from [127.0.0.1] by omp1027.mail.bf1.yahoo.com with NNFMP;
	02 Aug 2013 08:49:22 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 784757.60392.bm@omp1027.mail.bf1.yahoo.com
Received: (qmail 36563 invoked by uid 60001); 2 Aug 2013 08:49:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024;
	t=1375433362; bh=YwlylPRoWolwO0q864u1YW1t9qdsmiOTpRAqc6iwhdE=;
	h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type;
	b=G9AXmHuOW7k2ixMIP+1HNT2ewIN9yOCamWhPtVzcC3JLt+X0xKLDrz2s9QCwheQmfPEkBPC2J/xHo0rl7rwKjCetJPt6vu7YoaYvy5Li0tpcosY2ZOZ7Ezi92Xxm7wUPpVOrAMQjGES+qqtz2EZkqfPMMHIfH3fTrAH+uP9u/Vo=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=s1024; d=yahoo.com;
	h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type;
	b=HRyPMT+pQQeh5gFjKy4R/NugQgJwxnQ/b8HJ97Jgd2D/CEq6ufxjH1db2X17U0Ko32HW3Mq9o7mlcQjhtu3i8eD7dngKlNPYEQhf79dPFhLgyWJ853XnHmjFluGxozbRg4Ooex5+1v5GEdbAozdJbzHqEMHSrhDH+6v8tibcjSE=;
X-YMail-OSG: tOrnZV4VM1nnYY2y4AzaqA1skCroAbkp3Oi09iXa9LFl79o
	ZydKtSzXjBzzRwC7ZzFpGevIihB0sMVByrNAUNnMvnMO4ND8M7w1_hbhmvYn
	Y4ieMZfQoFe_2NJbo6cDNES7Pw7aqbA.rFpd.IOD8XAjyQp0FTspqqd5fRFN
	TrvTlVCLfDUUBK6UjqK_VOoHx.lFspVa9L4rfruBNmEHXNiCFLbO6iQ28Jg3
	WJHRPS9db8oe9mzX4Dg_z.PB3e_qX.lmT3et4tTGcpuyzMeFQCC_YMzf2kPu
	NIaWKPWaly3RG_dP0VX4fF54LXSPixubEc2j3Culvz2ea8igrq81iWb0972a
	i7Z9KQ7oC9VLz6xYNQhDnl_CPBo98sREBjvQuCNNvJJKpM1SRy_AYsYqpllR
	UxeMSZO9c9NQuMYJGmwL9WrJmtFVGDeWRODOrrWy4cO1YEyNc_eEuiNEfrfY
	zPd7ZVp2t6oF5vnwlgL9rp2jmijG5su.Rfo2GAPzTHrFHL9VZtXaDuaDaEGP
	0lQhSnUZM7w--
Received: from [72.163.217.102] by web162601.mail.bf1.yahoo.com via HTTP;
	Fri, 02 Aug 2013 01:49:22 PDT
X-Rocket-MIMEInfo: 002.001,
	CgpJIGFtIGEgbmV3YmllIHRvIE9FIGJpdGJha2UsIGFueSBnb29kIHJlZmVyZW5jZSB0byBzdGFydCB3aXRoPwoKQmVuaXguATABAQEB
X-Mailer: YahooMailWebService/0.8.152.567
Message-ID: <1375433362.36500.YahooMailNeo@web162601.mail.bf1.yahoo.com>
Date: Fri, 2 Aug 2013 01:49:22 -0700 (PDT)
From: Benix Vincent <benixvincent@yahoo.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
MIME-Version: 1.0
Subject: Any resource to start learning bitbake
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
Reply-To: Benix Vincent <benixvincent@yahoo.com>
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 02 Aug 2013 08:49:23 -0000
Content-Type: multipart/alternative;
	boundary="1829304633-1329687275-1375433362=:36500"

--1829304633-1329687275-1375433362=:36500
Content-Type: text/plain; charset=us-ascii



I am a newbie to OE bitbake, any good reference to start with?

Benix.

--1829304633-1329687275-1375433362=:36500
Content-Type: text/html; charset=us-ascii

<html><body><div style="color:#000; background-color:#fff; font-family:times new roman, new york, times, serif;font-size:12pt"><div><br></div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: 'times new roman', 'new york', times, serif; background-color: transparent; font-style: normal;">I am a newbie to OE bitbake, any good reference to start with?</div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: 'times new roman', 'new york', times, serif; background-color: transparent; font-style: normal;"><br></div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: 'times new roman', 'new york', times, serif; background-color: transparent; font-style: normal;">Benix.</div></div></body></html>

--1829304633-1329687275-1375433362=:36500--
