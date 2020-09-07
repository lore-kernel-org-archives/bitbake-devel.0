Subject: an idea about parallel doing do_patch
To: bitbake-devel@lists.openembedded.org
From: zhangyifan46@huawei.com
X-Originating-Location: CN (103.218.218.125)
X-Originating-Platform: Windows Chrome 85
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 07 Sep 2020 01:27:29 -0700
Message-ID: <iYPR.1599467249227446374.EQbU@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="pWMmOMCq6g04FFmR9oq0"

--pWMmOMCq6g04FFmR9oq0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

In our peoject,we have suffered a lot from long duration of do_patch of lin=
ux kernel(3000+ patches). I found that one do_patch task uses only one proc=
ess. So I modify a llittle do do_patch task. Here is my idea:
1.analyse the patches,only getting the modified files of each patch.
2.cluster all patches according to the files modified( patch no.1 modifies=
 file A,B ,patch no.2 modifies file A, patch no.3 modifies file C,then we c=
luster patch no.1 and no.2 as=C2=A0 a group, patch no.3 as another group) ,=
 here I use union-find to do the cluster
3.assign one group on one process
But I met the problem of probabilistic missing patches.
Anyone has any comments about my idea?

--pWMmOMCq6g04FFmR9oq0
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

In our peoject,we have suffered a lot from long duration of do_patch of lin=
ux kernel(3000+ patches). I found that one do_patch task uses only one proc=
ess. So I modify a llittle do do_patch task. Here is my idea:<br />1.analys=
e the patches,only getting the modified files of each patch.<br />2.cluster=
 all patches according to the files modified( patch no.1 modifies file A,B =
,patch no.2 modifies file A,&nbsp;<!--WeLinkPC-->patch no.3 modifies file C=
,then we cluster patch no.1 and no.2 as&nbsp; a group, patch no.3 as anothe=
r group) , here I use union-find to do the cluster<br />3.assign one group =
on one process<br />But I met the problem of probabilistic missing patches.=
<br />Anyone has any comments about my idea?

--pWMmOMCq6g04FFmR9oq0--
