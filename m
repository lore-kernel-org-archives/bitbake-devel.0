Return-Path: <yogesh.bit2006@gmail.com>
Received: from mail-ob0-f173.google.com (mail-ob0-f173.google.com
	[209.85.214.173])
	by mail.openembedded.org (Postfix) with ESMTP id C0AAD7579E
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Jun 2015 15:07:43 +0000 (UTC)
Received: by obew15 with SMTP id w15so10099398obe.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 03 Jun 2015 08:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to:content-type;
	bh=S6wcz0buj4g6t2zyH6uYfzu7/jTZdQTzMYiUz/qNG7k=;
	b=QmSbFgLUD8OXt5PjNpZEsWdBBjx6vACln8sxQBhAXJzBqkMjR2enzQZ3Cp9D15trRR
	Gs8nZc0qV/Yt6NlucCpZnNtt+d0iyDzBDn0aQk1+aFEOXG4zX6vx/agcJtZlMUYhYAQp
	6aZwdUsQbErzCpBn1qkH+iSunB/PyDC6zkOhPFfg9O+AuhxgX78a8ZS55/5e5efsho3K
	WV5bDQPKjUAitJTqKNxGswLLjnbAr7kZkFCm+PE1ZLYLjGvwCUTImbZMtBRC8W8ZIsUc
	VN3EfuaNwFB5XYKS5PQy/aScG8QNwmpuoGFhBKBsMprLt34Cg7cXCg/SrP7UbBIaOIrO
	5QkA==
X-Received: by 10.202.174.67 with SMTP id x64mr26146643oie.50.1433344064171;
	Wed, 03 Jun 2015 08:07:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.211.143 with HTTP; Wed, 3 Jun 2015 08:07:23 -0700 (PDT)
From: Yogesh Tyagi <yogesh.bit2006@gmail.com>
Date: Wed, 3 Jun 2015 20:37:23 +0530
Message-ID: <CADL-HDjZUp45887vfcpKKUC5FK8JD+3xA7LPxUXNa=yTPtaaYw@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: command to execute a set of task again in bitbake
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
X-List-Received-Date: Wed, 03 Jun 2015 15:07:51 -0000
Content-Type: multipart/alternative; boundary=001a113cefa4c9439205179e6b76

--001a113cefa4c9439205179e6b76
Content-Type: text/plain; charset=UTF-8

Hi,

Is it possible to force execution of certain tasks in bitbake. I want to
force execution of tasks from configure to package_write_rpm for one
package .

Thanks,
Yogesh

--001a113cefa4c9439205179e6b76
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Is it possible to force execution o=
f certain tasks in bitbake. I want to force execution of tasks from configu=
re to package_write_rpm for one package .</div><div><br></div><div>Thanks,<=
/div><div>Yogesh=C2=A0</div></div>

--001a113cefa4c9439205179e6b76--
