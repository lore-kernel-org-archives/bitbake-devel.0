Return-Path: <aaron@assonance.org>
Received: from mail-it1-f173.google.com (mail-it1-f173.google.com
	[209.85.166.173])
	by mail.openembedded.org (Postfix) with ESMTP id 272CB6C123
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Nov 2018 18:39:10 +0000 (UTC)
Received: by mail-it1-f173.google.com with SMTP id z7so129979iti.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Nov 2018 10:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=assonance-org.20150623.gappssmtp.com; s=20150623;
	h=mime-version:from:date:message-id:subject:to;
	bh=+TzZlgHKaAQbEOS3dP4ZqdUoifQzMxPAJ12e0mc1pw4=;
	b=zweHWC1wNkoLMpoQwgUWoT29ZftWMCq5AVpoQ9rqjEnVDhwpkhz8l6TDcJhMDHDGXL
	hy4syT/+PR+RYzw793EsiY/Y0KrT9vHKbIAVfZYT+IeoPbLmAlEWvj3IkHFkV7pkBQbx
	R2tzdbvBQtbxdLvvYRBilFhLS187AHni/Qmj3AroQT5yEy7uIM8vRDu1tGHzA+cYCO8Y
	AqStVi44A5XfpWo74C8CoLyJ1DyXNLxtG4RLc7LizdVATOq+T5sAAReDQx30dHNbnB8k
	KcMwynbJjp9/GVVJh5/bLQaRAOa2s2zvZJRBR5MKIT4DwA9WSBuNrDGlkynDONLmJpmX
	eInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=+TzZlgHKaAQbEOS3dP4ZqdUoifQzMxPAJ12e0mc1pw4=;
	b=jV/VLDMvxLX8Gx7OIb7+9ec56PDl6Rvvc+wrDfNHRu4mBEpxdQVRcalRNU4XNCmW9g
	O1NnqY5JA1r8TAdG81NwDZegASB1+U7O7UF1w898WHMujzg2Eku8+/XMpOA6M2vqp28r
	opOdGWgPb18arKGK2odx5dojEBrv2IzEKilej25fMEiWBb2aYSp1zvjN3ePOIBBuOr93
	A3Q8GhXSuJeu/LNt7VSWg9bQlLeCFMzPol275suFUYKxasxprEpW1ShTS+ZH5/mbAsGn
	meogytV6GgN1qYu+WTjCpclqepX5jLYHr7oOlaf3U8sTIEdxlSrKf6WpKGUOE/DFaq42
	a7vw==
X-Gm-Message-State: AA+aEWaX08meCrDxDEdjfWl4MEhoxZ4vVOT/ekpN5XSAcjEA41X4s5J4
	jvSdAAvDvLKUgzQLuK0ACR+Naks1an7/5jqSSXd6MFOKcYI=
X-Google-Smtp-Source: AFSGD/Utg73tWFqKK3K7e6lEg2WTQnNLblEQsGC3eJAzh0jSI0zHJ1jewl1IEqFZyEPxvFEDtgO/1oefgw0nHqfs0pI=
X-Received: by 2002:a24:ce42:: with SMTP id v63mr42335itg.136.1543343950704;
	Tue, 27 Nov 2018 10:39:10 -0800 (PST)
MIME-Version: 1.0
From: Aaron Cohen <aaron@assonance.org>
Date: Tue, 27 Nov 2018 13:38:47 -0500
Message-ID: <CAFSZm+gAZkZ5ukZxKs6xuF1UcUsYNLepASAFQ3rOH9B38qcAYQ@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Mercurial fetcher doesn't work for me (patch included)
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
X-List-Received-Date: Tue, 27 Nov 2018 18:39:10 -0000
X-Groupsio-MsgNum: 9782
Content-Type: multipart/mixed; boundary="000000000000f31a83057ba9c3b5"

--000000000000f31a83057ba9c3b5
Content-Type: multipart/alternative; boundary="000000000000f31a80057ba9c3b3"

--000000000000f31a80057ba9c3b3
Content-Type: text/plain; charset="UTF-8"

I'm trying to write a recipe for a local repo that is kept in mercurial,
and encountering the following problem:


> Traceback (most recent call last):
>   File "/home/joel-cohen/code/waveos2/poky/bitbake/lib/bb/data_smart.py",
> line 808, in DataSmart.getVarFlag(var='PV', flag='_content', expand=True,
> noweakdefault=False, parsing=False, retparser=False):
>              if expand or retparser:
>     >            parser = self.expandWithRefs(value, cachename)
>              if expand:
>   File "/home/joel-cohen/code/waveos2/poky/bitbake/lib/bb/data_smart.py",
> line 416, in DataSmart.expandWithRefs(s='0.0.4+git${SRCPV}', varname='PV'):
>                  try:
>     >                s = __expand_var_regexp__.sub(varparse.var_sub, s)
>                      try:
>   File "/home/joel-cohen/code/waveos2/poky/bitbake/lib/bb/data_smart.py",
> line 108, in VariableParse.var_sub(match=<_sre.SRE_Match object; span=(9,
> 17), match='${SRCPV}'>):
>                          raise Exception("variable %s references itself!"
> % self.varname)
>     >            var = self.d.getVarFlag(key, "_content")
>                  self.references.add(key)
>   File "/home/joel-cohen/code/waveos2/poky/bitbake/lib/bb/data_smart.py",
> line 808, in DataSmart.getVarFlag(var='SRCPV', flag='_content',
> expand=True, noweakdefault=False, parsing=False, retparser=False):
>              if expand or retparser:
>     >            parser = self.expandWithRefs(value, cachename)
>              if expand:
>   File "/home/joel-cohen/code/waveos2/poky/bitbake/lib/bb/data_smart.py",
> line 430, in DataSmart.expandWithRefs(s='${@bb.fetch2.get_srcrev(d)}',
> varname='SRCPV'):
>                  except Exception as exc:
>     >                raise ExpansionError(varname, s, exc) from exc
>
> bb.data_smart.ExpansionError: Failure expanding variable SRCPV, expression
> was ${@bb.fetch2.get_srcrev(d)} which triggered exception AttributeError:
> 'FetchData' object has no attribute 'moddir'


I've fixed this with the following patch, which moves some code in the Hg
fetcher to later in the urldata_init method, after some necessary variables
have been initialized. I'm not sure if I'm alone in seeing this problem or
not?


ALSO (I'm not sure if this is bitbake-related or poky-related): what is it
that is supposed to create the $(BUILDDIR)/tmp/hosttools/hg symlink?

For some reason, this link is not created for me automatically. It works
fine if I create it manually.


Thanks for any help,
Aaron

--000000000000f31a80057ba9c3b3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I&#39;m trying to write a recipe for a local repo tha=
t is kept in mercurial, and encountering the following problem:</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Traceback (mo=
st recent call last):<br>=C2=A0 File &quot;/home/joel-cohen/code/waveos2/po=
ky/bitbake/lib/bb/data_smart.py&quot;, line 808, in DataSmart.getVarFlag(va=
r=3D&#39;PV&#39;, flag=3D&#39;_content&#39;, expand=3DTrue, noweakdefault=
=3DFalse, parsing=3DFalse, retparser=3DFalse):<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if expand or retparser:<br>=C2=A0 =C2=A0 &gt;=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser =3D self.expandWithRefs(value, c=
achename)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if expand:<br>=
=C2=A0 File &quot;/home/joel-cohen/code/waveos2/poky/bitbake/lib/bb/data_sm=
art.py&quot;, line 416, in DataSmart.expandWithRefs(s=3D&#39;0.0.4+git${SRC=
PV}&#39;, varname=3D&#39;PV&#39;):<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s =3D __expand_var_regexp__.sub(varparse=
.var_sub, s)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0try:<br>=C2=A0 File &quot;/home/joel-cohen/code/waveos2/po=
ky/bitbake/lib/bb/data_smart.py&quot;, line 108, in VariableParse.var_sub(m=
atch=3D&lt;_sre.SRE_Match object; span=3D(9, 17), match=3D&#39;${SRCPV}&#39=
;&gt;):<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0raise Exception(&quot;variable %s references its=
elf!&quot; % self.varname)<br>=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 var =3D self.d.getVarFlag(key, &quot;_content&quot;)<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.references.=
add(key)<br>=C2=A0 File &quot;/home/joel-cohen/code/waveos2/poky/bitbake/li=
b/bb/data_smart.py&quot;, line 808, in DataSmart.getVarFlag(var=3D&#39;SRCP=
V&#39;, flag=3D&#39;_content&#39;, expand=3DTrue, noweakdefault=3DFalse, pa=
rsing=3DFalse, retparser=3DFalse):<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if expand or retparser:<br>=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 parser =3D self.expandWithRefs(value, cachename)<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if expand:<br>=C2=A0 File=
 &quot;/home/joel-cohen/code/waveos2/poky/bitbake/lib/bb/data_smart.py&quot=
;, line 430, in DataSmart.expandWithRefs(s=3D&#39;${@bb.fetch2.get_srcrev(d=
)}&#39;, varname=3D&#39;SRCPV&#39;):<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0except Exception as exc:<br>=C2=A0 =C2=A0 &gt;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ExpansionErro=
r(varname, s, exc) from exc<br>=C2=A0 =C2=A0 =C2=A0<br>bb.data_smart.Expans=
ionError: Failure expanding variable SRCPV, expression was ${@bb.fetch2.get=
_srcrev(d)} which triggered exception AttributeError: &#39;FetchData&#39; o=
bject has no attribute &#39;moddir&#39;</blockquote><div><br></div><div>I&#=
39;ve fixed this with the following patch, which moves some code in the Hg =
fetcher to later in the urldata_init method, after some necessary variables=
 have been initialized. I&#39;m not sure if I&#39;m alone in seeing this pr=
oblem or not?</div><div><br></div><div><br></div><div>ALSO (I&#39;m not sur=
e if this is bitbake-related or poky-related): what is it that is supposed =
to create the $(BUILDDIR)/tmp/hosttools/hg symlink?=C2=A0</div><div><div><b=
r></div><div>For some reason, this link is not created for me automatically=
. It works fine if I create it manually.</div></div><div><br></div><div><br=
></div><div>Thanks for any help,</div><div>Aaron</div></div>

--000000000000f31a80057ba9c3b3--

--000000000000f31a83057ba9c3b5
Content-Type: text/x-patch; charset="US-ASCII"; name="poky.patch"
Content-Disposition: attachment; filename="poky.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jp033cqp0>
X-Attachment-Id: f_jp033cqp0

ZGlmZiAtLWdpdCBhL2JpdGJha2UvbGliL2JiL2ZldGNoMi9oZy5weSBiL2JpdGJha2UvbGliL2Ji
L2ZldGNoMi9oZy5weQppbmRleCA5MzZkMDQzLi45NzkwZTFiIDEwMDY0NAotLS0gYS9iaXRiYWtl
L2xpYi9iYi9mZXRjaDIvaGcucHkKKysrIGIvYml0YmFrZS9saWIvYmIvZmV0Y2gyL2hnLnB5CkBA
IC02NiwxMyArNjYsNiBAQCBjbGFzcyBIZyhGZXRjaE1ldGhvZCk6CiAgICAgICAgIGVsc2U6CiAg
ICAgICAgICAgICB1ZC5wcm90byA9ICJoZyIKIAotICAgICAgICB1ZC5zZXR1cF9yZXZpc2lvbnMo
ZCkKLQotICAgICAgICBpZiAncmV2JyBpbiB1ZC5wYXJtOgotICAgICAgICAgICAgdWQucmV2aXNp
b24gPSB1ZC5wYXJtWydyZXYnXQotICAgICAgICBlbGlmIG5vdCB1ZC5yZXZpc2lvbjoKLSAgICAg
ICAgICAgIHVkLnJldmlzaW9uID0gc2VsZi5sYXRlc3RfcmV2aXNpb24odWQsIGQpCi0KICAgICAg
ICAgIyBDcmVhdGUgcGF0aHMgdG8gbWVyY3VyaWFsIGNoZWNrb3V0cwogICAgICAgICBoZ3NyY25h
bWUgPSAnJXNfJXNfJXMnICUgKHVkLm1vZHVsZS5yZXBsYWNlKCcvJywgJy4nKSwgXAogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVkLmhvc3QsIHVkLnBhdGgucmVwbGFjZSgnLycsICcuJykp
CkBAIC04Niw2ICs3OSwxNCBAQCBjbGFzcyBIZyhGZXRjaE1ldGhvZCk6CiAgICAgICAgIHVkLmxv
Y2FsZmlsZSA9IHVkLm1vZGRpcgogICAgICAgICB1ZC5iYXNlY21kID0gZC5nZXRWYXIoIkZFVENI
Q01EX2hnIikgb3IgIi91c3IvYmluL2VudiBoZyIKIAorICAgICAgICB1ZC5zZXR1cF9yZXZpc2lv
bnMoZCkKKworICAgICAgICBpZiAncmV2JyBpbiB1ZC5wYXJtOgorICAgICAgICAgICAgdWQucmV2
aXNpb24gPSB1ZC5wYXJtWydyZXYnXQorICAgICAgICBlbGlmIG5vdCB1ZC5yZXZpc2lvbjoKKyAg
ICAgICAgICAgIHVkLnJldmlzaW9uID0gc2VsZi5sYXRlc3RfcmV2aXNpb24odWQsIGQpCisKKwog
ICAgICAgICB1ZC53cml0ZV90YXJiYWxscyA9IGQuZ2V0VmFyKCJCQl9HRU5FUkFURV9NSVJST1Jf
VEFSQkFMTFMiKQogCiAgICAgZGVmIG5lZWRfdXBkYXRlKHNlbGYsIHVkLCBkKToK

--000000000000f31a83057ba9c3b5--
