Return-Path: <parmesh.iiit@gmail.com>
Received: from mail-vk0-f42.google.com (mail-vk0-f42.google.com
	[209.85.213.42])
	by mail.openembedded.org (Postfix) with ESMTP id D2D806080F
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Mar 2016 09:05:14 +0000 (UTC)
Received: by mail-vk0-f42.google.com with SMTP id c3so9390892vkb.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 08 Mar 2016 01:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to;
	bh=2z2I1AWRe3+bxytYzJ+iuwgWOmKNQuuHMoegHCVwsWs=;
	b=qBlCz1yNZEq5Atsvxm7ZmcvqzyzmPqLIUpIDWJV3vCPwbHZIV8Sr5VQBwFfiTNbMAP
	kFzQQSknuN0NiyUnvIzFSxb+gRP8gHdfeb+eBJ9i+2I5S3P3hQE/Y86jg8HdZDsUaI+w
	3XCRckc96qDY4GjnYvEhCymo1Kn6bRmqsoBli2jYEqa0n2/ambjGQA2gUXGy35W8TD4q
	nGl3Iy8rBhLISQqs+tIIGacUcjkwpbIAL54OfKuRvzYp3VETVbKmn16mdG56g5Nwwdf2
	OzoUUexs+JBQ/uv9ft7WhfTLgu64CmGXBiI4adNYF9VAFWXcmuy9j0IrwenZz55qc/+3
	3L8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
	bh=2z2I1AWRe3+bxytYzJ+iuwgWOmKNQuuHMoegHCVwsWs=;
	b=a457ngd1LSSaVJ1hBd2iJ9QjOQToJepT4vNj/mRTmLa9qRoqO1N+3ngoTmbZZhcJUV
	uvZivkaP14EeudNQG26WtlCziW8N6b1RZwmfEG9vb2J84igNFqhY2qmfR2WkTXMI7PnK
	0FLMddYYr3R1k2VmJ7fByhUYctno3LLptI7iUtp3oZOYRHNipE8ZL0klNqxVp+Dr/e77
	8AIRLyCoaCz3srdzK+VtmkgS0IQPAzP6nE4YU9VCVcjGBXl9RwARql27djaJQ0oU2LfO
	k2pUYcNr7H9axybe2GBoBV4abOtbiMONcIoZ1x2tLiiZMv8fB/itumbIhSkKmOD2eXdx
	IW+Q==
X-Gm-Message-State: AD7BkJIo7JK5DDbuKeMBYKQbT4HBQn1sWtLh2pP1ds9QE20CXe3AhBJOeHxsO1g4QiWSQKQSq6a+HjWG2NOSBA==
MIME-Version: 1.0
X-Received: by 10.31.11.201 with SMTP id 192mr24742843vkl.135.1457427914742;
	Tue, 08 Mar 2016 01:05:14 -0800 (PST)
Received: by 10.31.136.19 with HTTP; Tue, 8 Mar 2016 01:05:14 -0800 (PST)
Date: Tue, 8 Mar 2016 14:35:14 +0530
Message-ID: <CACBNtJa19jVXqcc7Z+y=e1nm-fYF=R=7X9h0htPaV8bRGHnttg@mail.gmail.com>
From: parmeshwar tak <parmesh.iiit@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Adding a path to PATH variable.
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
X-List-Received-Date: Tue, 08 Mar 2016 09:05:15 -0000
Content-Type: multipart/alternative; boundary=001a1145515224e0e6052d85e111

--001a1145515224e0e6052d85e111
Content-Type: text/plain; charset=UTF-8

Hi All,
I have one problem that we are migrating the legacy build system to yocto.
There is one path, which has the all utilities.
I want to add a specific path to PATH variable, such that It will be
available for all the processes.

Where I should add this in yocto/bitbake ?

I don't want to add each and every process..


-- 
Regards
-----------------------------
~Parmeshwar Tak~
MSIT 2010
IIIT Hyderabad

--001a1145515224e0e6052d85e111
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi All,<br></div>I have one problem that we=
 are migrating the legacy build system to yocto.<br>There is one path, whic=
h has the all utilities.<br>I want to add a specific path to PATH variable,=
 such that It will be available for all the processes.<br></div><br>Where I=
 should add this in yocto/bitbake ?<br><br></div>I don&#39;t want to add ea=
ch and every process..<br><div><br clear=3D"all"><div><div><div><br>-- <br>=
<div class=3D"gmail_signature">Regards<br>-----------------------------<br>=
~Parmeshwar Tak~<br>MSIT 2010<br>IIIT Hyderabad<br></div>
</div></div></div></div></div>

--001a1145515224e0e6052d85e111--
