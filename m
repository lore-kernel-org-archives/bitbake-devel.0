Subject: Significance of "SRCREV_FORMAT" variable for multiple sources fetch
To: bitbake-devel@lists.openembedded.org
From: "Abhishek Shah" <abhishek.shah@broadcom.com>
X-Originating-Location: Bengaluru, Karnataka, IN (103.252.25.84)
X-Originating-Platform: Windows Chrome 80
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 17 Apr 2020 11:45:01 -0700
Message-ID: <Gw3N.1587149101751917659.pi0R@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="Co52M5vmtDrGFeLSe3HO"

--Co52M5vmtDrGFeLSe3HO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

We have a recipe, which has multiple SRC_URI. For each SRC_URI, we have sp=
ecified=C2=A0SRCREV using SRCREV_name.

I am facing issue when trying to add one more SRC_URI:

While adding new source, I am updating=C2=A0SRCREV_FORMAT variable.
This causea lengthening of PATH where all the fetched source are downloade=
d.
For example, if earlier location was
tmp/yocto_build/poky/build/tmp/work/aarch64-poky-linux/xxx/gitAUTOINC+a20a=
30cd86_dbbf7c9b30_f3635d87f4_90d93a11ba_ae871b61ae_5ba575618e-r0/git/
new location would be elongated something like:
tmp/yocto_build/poky/build/tmp/work/aarch64-poky-linux/xxx/gitAUTOINC+a20a=
30cd86_ bfa48a337e_ dbbf7c9b30_f3635d87f4_90d93a11ba_ae871b61ae_5ba575618e-=
r0/git/

One of the source is using a Python script, which is using absolute PATH t=
o create a symlink.
Because of elongated PATH, I get below error:
os.symlink(directory, symlink)
OSError: [Errno 36] File name too long

If I don't update SRCREV_FORMAT=C2=A0variable even after adding new source=
, I do not see above issue.

So, the question is, is that okay if we do not update SRCREV_FORMAT=C2=A0 =
when adding new SRC_URI in the bitbake recipe?

--Co52M5vmtDrGFeLSe3HO
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,<br /><br />We have a recipe, which has multiple SRC_URI. For each SRC_U=
RI, we have specified&nbsp;SRCREV using SRCREV_name.<br /><br />I am facing=
 issue when trying to add one more SRC_URI:<br /><br />While adding new sou=
rce, I am updating&nbsp;SRCREV_FORMAT variable.<br />This causea lengthenin=
g of PATH where all the fetched source are downloaded.<br />For example, if=
 earlier location was<br /><span style=3D"color: #000000; font-family: 'Cou=
rier New', Courier, monospace; font-size: 11.2px; white-space: pre-wrap;">t=
mp/yocto_build/poky/build/tmp/work/aarch64-poky-linux/xxx/gitAUTOINC+a20a30=
cd86_dbbf7c9b30_f3635d87f4_90d93a11ba_ae871b61ae_5ba575618e-r0/git/</span><=
br />new location would be elongated something like:<br /><span style=3D"co=
lor: #000000; font-family: 'Courier New', Courier, monospace; font-size: 11=
.2px; white-space: pre-wrap;">tmp/yocto_build/poky/build/tmp/work/aarch64-p=
oky-linux/xxx/gitAUTOINC+a20a30cd86_</span><span style=3D"color: #000000; f=
ont-family: 'Courier New', Courier, monospace; font-size: 11.2px; white-spa=
ce: pre-wrap;">bfa48a337e_</span><span style=3D"color: #000000; font-family=
: 'Courier New', Courier, monospace; font-size: 11.2px; white-space: pre-wr=
ap;">dbbf7c9b30_f3635d87f4_90d93a11ba_ae871b61ae_5ba575618e-r0/git/<br /></=
span><br />One of the source is using a Python script, which is using absol=
ute PATH to create a symlink.<br />Because of elongated PATH, I get below e=
rror:<br /><span style=3D"color: #000000; font-family: 'Courier New', Couri=
er, monospace; font-size: 11.2px; white-space: pre-wrap;">os.symlink(direct=
ory, symlink)</span><br style=3D"color: #000000; font-family: 'Courier New'=
, Courier, monospace; font-size: 11.2px; white-space: pre-wrap;" /><span st=
yle=3D"color: #000000; font-family: 'Courier New', Courier, monospace; font=
-size: 11.2px; white-space: pre-wrap;">OSError: [Errno 36] File name too lo=
ng<br /><br /></span>If I don't update SRCREV_FORMAT&nbsp;variable even aft=
er adding new source, I do not see above issue.<br /><br />So, the question=
 is, is that okay if we do not update SRCREV_FORMAT&nbsp; when adding new S=
RC_URI in the bitbake recipe?

--Co52M5vmtDrGFeLSe3HO--
