Subject: Re: Significance of "SRCREV_FORMAT" variable for multiple sources fetch
To: bitbake-devel@lists.openembedded.org
From: "Abhishek Shah" <abhishek.shah@broadcom.com>
X-Originating-Location: Bengaluru, Karnataka, IN (103.252.25.193)
X-Originating-Platform: Windows Chrome 80
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Sat, 18 Apr 2020 13:00:22 -0700
References: <CANNYZj_xP2UtR5Ohx5ufGv5UZHQjR51+iTashoPckm-C3BWHkw@mail.gmail.com>
In-Reply-To: <CANNYZj_xP2UtR5Ohx5ufGv5UZHQjR51+iTashoPckm-C3BWHkw@mail.gmail.com>
Message-ID: <2736.1587240022802553223@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="ONSyP0jdU2jCo9M3LokO"

--ONSyP0jdU2jCo9M3LokO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thanks.

FYI, here is the example directory and its symlink:
directory path:
'/tmp/yocto_builds/ 20133855_ genericx86-64/poky/build/tmp/work/
aarch64-poky-linux/brcm-zephyr/gitAUTOINC+a20a30cd86_bfa48a337e_dbbf7c9b30=
_f3635d87f4_90d93a11ba_ae871b61ae_5ba575618e-r0/git/
zephyr/include/arch/arm/aarch32/cortex_m/mpu'

It's symlink created by subfolder_list.py:
'/tmp/yocto_builds/ 20133855_ genericx86-64/poky/build/tmp/work/
aarch64-poky-linux/brcm-zephyr/gitAUTOINC+a20a30cd86_bfa48a337e_dbbf7c9b30=
_f3635d87f4_90d93a11ba_ae871b61ae_5ba575618e-r0/git/
zephyr/samples/hello_world/build_soc/zephyr/misc/generated/syscalls_links/
_tmp_yocto_builds_20133855_genericx86-64_poky_build_tmp_work_aarch64-poky-=
linux_brcm-zephyr_gitAUTOINC+a20a30cd86_bfa48a337e_dbbf7c9b30_f3635d87f4_90=
d93a11ba_ae871b61ae_5ba575618e-r0_git_zephyr_include_arch_arm_aarch32_corte=
x_m_mpu'

I have dropped an mail to community to take it further in direction of red=
ucing symlink length:
https://lists.zephyrproject.org/g/devel/message/6944

Regards,
Abhishek

--ONSyP0jdU2jCo9M3LokO
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thanks.<br /><br />FYI, here is the example directory and its symlink:<br /=
>
<div>directory path:</div>
<div>'/tmp/yocto_builds/ 20133855_ genericx86-64/poky/build/tmp/work/<br /=
>aarch64-poky-linux/brcm-zephyr/gitAUTOINC+a20a30cd86_bfa48a337e_dbbf7c9b30=
_f3635d87f4_90d93a11ba_ae871b61ae_5ba575618e-r0/git/<br />zephyr/include/ar=
ch/arm/aarch32/cortex_m/mpu'</div>
<div>&nbsp;</div>
<div>It's symlink created by subfolder_list.py:</div>
<div>&nbsp;'/tmp/yocto_builds/ 20133855_ genericx86-64/poky/build/tmp/work=
/<br />aarch64-poky-linux/brcm-zephyr/gitAUTOINC+a20a30cd86_bfa48a337e_dbbf=
7c9b30_f3635d87f4_90d93a11ba_ae871b61ae_5ba575618e-r0/git/<br />zephyr/samp=
les/hello_world/build_soc/zephyr/misc/generated/syscalls_links/<br />_tmp_y=
octo_builds_20133855_genericx86-64_poky_build_tmp_work_aarch64-poky-linux_b=
rcm-zephyr_gitAUTOINC+a20a30cd86_bfa48a337e_dbbf7c9b30_f3635d87f4_90d93a11b=
a_ae871b61ae_5ba575618e-r0_git_zephyr_include_arch_arm_aarch32_cortex_m_mpu=
'</div>
<div>&nbsp;</div>
I have dropped an mail to community to take it further in direction of red=
ucing symlink length:<br /><a href=3D"https://lists.zephyrproject.org/g/dev=
el/message/6944">https://lists.zephyrproject.org/g/devel/message/6944</a><b=
r /><br />Regards,<br />Abhishek

--ONSyP0jdU2jCo9M3LokO--
