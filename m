Return-Path: <sujith.h@gmail.com>
Received: from mail-qk0-f169.google.com (mail-qk0-f169.google.com
	[209.85.220.169])
	by mail.openembedded.org (Postfix) with ESMTP id D87106FFCE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Nov 2016 09:24:46 +0000 (UTC)
Received: by mail-qk0-f169.google.com with SMTP id n204so14470791qke.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Nov 2016 01:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to;
	bh=7B1OulL66O4ti72t3/UYhBbDHT+gMdbwlSf5CvSpQys=;
	b=pg593oD6mjOWykTKeDNPES4fkVRYl+EKYkY/L4GAVi9L7Q/iod6r7xHQJmyzRaZN31
	bYavv9xw4qYZ7Qp/4KAU7pGDkaZHJmoFvBayGpCN2MG2QtYB+17YR1m0jTyZT9OTp2G5
	ROBgZoGYXgueFCpFPZJYcTuAoGFd04x764yEDYGGwyIQE68+aahKifqkh7DEWFApA/ag
	nLeWCTXP5nZ5RmRZezzU5XgWhKXoNT2dA9IFAlODip+XGAzgPcjJFcPbYPQiEayGGB02
	PYDG6RHvVqv/VEHg7BJgI/Y2PUzYrBc4pS5JgTxjxvfCbL+gWxfTLSScazP5nlXZ7tQU
	33oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=7B1OulL66O4ti72t3/UYhBbDHT+gMdbwlSf5CvSpQys=;
	b=aRsw4Q4BaacskBEo2o1IUWeU0SyWoFxlkHE1ccLsnNclSLXLomUhLG70FUojy2H/Mg
	LAdgsLyDoGRhYmV+lgsHmeH8rSwmbbHrALmbu2pweTY1vrIf5fpkWx/crqH7VkgMBsyD
	vWiEKu5DAF3LgodYKv9gqomAQr3BvH6iYKtOt2Jbx6fxzs6uk70dL1EYWWvNxVs808hC
	u/Sd1f6gld1AAh01VQEd+QG1C/Qk0WpdvuAHyLAgaSnNKC5tWR0SszIZ/YppL1Tw12wg
	SxzfVbUaB+Kkfm+gp0HQpyeNWWuD6S+BinYnP4ZOrt1uzkzr9xEsfj5aeH9aaNzcJ/D8
	xucA==
X-Gm-Message-State: AKaTC01vyG0wsJEOmN3qYLW0ezoruJLxA+2vokSfI2S1Mtf6uOKBKWWrqAvkoubY8QADWtd2Iniyc4UPClqukg==
X-Received: by 10.55.11.136 with SMTP id 130mr20463670qkl.291.1479806687120;
	Tue, 22 Nov 2016 01:24:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.55.195.221 with HTTP; Tue, 22 Nov 2016 01:24:26 -0800 (PST)
From: sujith h <sujith.h@gmail.com>
Date: Tue, 22 Nov 2016 14:54:26 +0530
Message-ID: <CADyYWLmiBkOd9xuc2SqfUG3sO6FdLGd9y5=+SNtGCCVC65tZ8w@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: getAllKeysWithFlags: Issue when returning the dump var
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
X-List-Received-Date: Tue, 22 Nov 2016 09:24:49 -0000
Content-Type: multipart/alternative; boundary=001a114c23f2ec1cb90541e05710

--001a114c23f2ec1cb90541e05710
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I found a small issue while building a recipe/image in toaster. The problem
I saw is when toaster completes parsing, I could see an error in the
toaster_ui.log as:

ERROR: <Fault 1: "<class 'TypeError'>:cannot marshal <class '_thread.lock'>
objects">
Traceback (most recent call last):
  File
"/home/sujith/MEL/toaster-latest/poky/bitbake/lib/bb/ui/toasterui.py", line
256, in main
    buildinfohelper.save_build_layers_and_variables()
  File
"/home/sujith/MEL/toaster-latest/poky/bitbake/lib/bb/ui/buildinfohelper.py"=
,
line 1151, in save_build_layers_and_variables
    data =3D self.server.runCommand(["getAllKeysWithFlags", ["doc",
"func"]])[0]
  File "/usr/lib/python3.4/xmlrpc/client.py", line 1098, in __call__
    return self.__send(self.__name, args)
  File "/usr/lib/python3.4/xmlrpc/client.py", line 1437, in __request
    verbose=3Dself.__verbose
  File "/usr/lib/python3.4/xmlrpc/client.py", line 1140, in request
    return self.single_request(host, handler, request_body, verbose)
  File "/usr/lib/python3.4/xmlrpc/client.py", line 1156, in single_request
    return self.parse_response(resp)
  File "/usr/lib/python3.4/xmlrpc/client.py", line 1327, in parse_response
    return u.close()
  File "/usr/lib/python3.4/xmlrpc/client.py", line 657, in close
    raise Fault(**self._stack[0])
xmlrpc.client.Fault: <Fault 1: "<class 'TypeError'>:cannot marshal <class
'_thread.lock'> objects">


This error doesn't stops the building of a recipe or image which is
triggered. After seeing this error I tried to modify the cooker.py code for
getAllKeysWithFlags, at the end ( before it returns dump ), to write to a
file a.py:

fd.write("a =3D %s\n" %(str(dump)))

And tried to import the file a.py. The moment I tried to import it, I was
getting syntax error. Any helping hand would be nice for me to move ahead
with this issue. If my understanding is correct, its not a toaster issue.
Pardon me if my understanding is wrong.

Thanks,
Sujith H

--=20
=E0=B4=B8=E0=B5=81=E0=B4=9C=E0=B4=BF=E0=B4=A4=E0=B5=8D =E0=B4=B9=E0=B4=B0=
=E0=B4=BF=E0=B4=A6=E0=B4=BE=E0=B4=B8=E0=B4=A8=E0=B5=8D
Bangalore
<Project>Contributor to KDE project
<Project>Contributor to Yocto project
http://fci.wikia.com/wiki/Anti-DRM-Campaign
<Blog> http://sujithh.info
C-x C-c

--001a114c23f2ec1cb90541e05710
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div>Hi,<br><br></div>I found a s=
mall issue while building a recipe/image in toaster. The problem I saw is w=
hen toaster completes parsing, I could see an error in the toaster_ui.log a=
s:<br><br>ERROR: &lt;Fault 1: &quot;&lt;class &#39;TypeError&#39;&gt;:canno=
t marshal &lt;class &#39;_thread.lock&#39;&gt; objects&quot;&gt;<br>Traceba=
ck (most recent call last):<br>=C2=A0 File &quot;/home/sujith/MEL/toaster-l=
atest/poky/bitbake/lib/bb/ui/toasterui.py&quot;, line 256, in main<br>=C2=
=A0=C2=A0=C2=A0 buildinfohelper.save_build_layers_and_variables()<br>=C2=A0=
 File &quot;/home/sujith/MEL/toaster-latest/poky/bitbake/lib/bb/ui/buildinf=
ohelper.py&quot;, line 1151, in save_build_layers_and_variables<br>=C2=A0=
=C2=A0=C2=A0 data =3D self.server.runCommand([&quot;getAllKeysWithFlags&quo=
t;, [&quot;doc&quot;, &quot;func&quot;]])[0]<br>=C2=A0 File &quot;/usr/lib/=
python3.4/xmlrpc/client.py&quot;, line 1098, in __call__<br>=C2=A0=C2=A0=C2=
=A0 return self.__send(self.__name, args)<br>=C2=A0 File &quot;/usr/lib/pyt=
hon3.4/xmlrpc/client.py&quot;, line 1437, in __request<br>=C2=A0=C2=A0=C2=
=A0 verbose=3Dself.__verbose<br>=C2=A0 File &quot;/usr/lib/python3.4/xmlrpc=
/client.py&quot;, line 1140, in request<br>=C2=A0=C2=A0=C2=A0 return self.s=
ingle_request(host, handler, request_body, verbose)<br>=C2=A0 File &quot;/u=
sr/lib/python3.4/xmlrpc/client.py&quot;, line 1156, in single_request<br>=
=C2=A0=C2=A0=C2=A0 return self.parse_response(resp)<br>=C2=A0 File &quot;/u=
sr/lib/python3.4/xmlrpc/client.py&quot;, line 1327, in parse_response<br>=
=C2=A0=C2=A0=C2=A0 return u.close()<br>=C2=A0 File &quot;/usr/lib/python3.4=
/xmlrpc/client.py&quot;, line 657, in close<br>=C2=A0=C2=A0=C2=A0 raise Fau=
lt(**self._stack[0])<br>xmlrpc.client.Fault: &lt;Fault 1: &quot;&lt;class &=
#39;TypeError&#39;&gt;:cannot marshal &lt;class &#39;_thread.lock&#39;&gt; =
objects&quot;&gt;<br><br><br></div>This error doesn&#39;t stops the buildin=
g of a recipe or image which is triggered. After seeing this error I tried =
to modify the cooker.py code for getAllKeysWithFlags, at the end ( before i=
t returns dump ), to write to a file a.py:<br><br></div>fd.write(&quot;a =
=3D %s\n&quot; %(str(dump)))<br><br></div>And tried to import the file a.py=
. The moment I tried to import it, I was getting syntax error. Any helping =
hand would be nice for me to move ahead with this issue. If my understandin=
g is correct, its not a toaster issue. Pardon me if my understanding is wro=
ng.<br><br></div>Thanks,<br></div>Sujith H<br clear=3D"all"><div><div><div>=
<div><div><div><div><div><br>-- <br><div class=3D"gmail_signature"><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div>=E0=B4=B8=E0=B5=81=E0=B4=9C=E0=B4=BF=E0=
=B4=A4=E0=B5=8D =E0=B4=B9=E0=B4=B0=E0=B4=BF=E0=B4=A6=E0=B4=BE=E0=B4=B8=E0=
=B4=A8=E0=B5=8D<br>Bangalore<br>&lt;Project&gt;Contributor to KDE project<b=
r></div><div>&lt;Project&gt;Contributor to Yocto project<br></div><div><a h=
ref=3D"http://fci.wikia.com/wiki/Anti-DRM-Campaign" target=3D"_blank">http:=
//fci.wikia.com/wiki/Anti-DRM-Campaign</a><br>&lt;Blog&gt; <a href=3D"http:=
//sujithh.info" target=3D"_blank">http://sujithh.info</a><br></div><div>C-x=
 C-c<br></div></div></div></div></div>
</div></div></div></div></div></div></div></div></div>

--001a114c23f2ec1cb90541e05710--
